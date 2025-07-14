import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/video_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UserModeViewmodel extends ChangeNotifier {
  int selectedbtn = 0;
  int selectedVideo = 0;
  VideoPlayerController? controller;
  final Map<String, Uint8List?> thumbnailCache = {};
  Timer? _timer;
  Timer? _videoTimer;
  // 10 minutes
  int elapsedSeconds = 0;
  Duration currentPosition = Duration.zero;
  bool isControllerInitialized = false;
  int remainingSeconds = 0;
  int totalTime = 0;

  void playAndPause() {
    if (controller!.value.isPlaying) {
      controller!.pause();
      notifyListeners();
    } else {
      controller!.play();
      stopTimer();
      startVideoTimer();
      notifyListeners();
    }
  }

  void startVideoTimer() {
    _videoTimer?.cancel();
    _videoTimer = Timer.periodic(Duration(seconds: 1), (_) {
      if (controller != null && controller!.value.isInitialized) {
        currentPosition = controller!.value.position;
        notifyListeners();
      }
    });
  }

  void initializeController(String url) async {
    isControllerInitialized = false;
    currentPosition = Duration.zero;
    notifyListeners();

    if (controller != null) {
      await controller!.dispose();
    }

    controller = VideoPlayerController.networkUrl(Uri.parse(url));

    try {
      await controller!.initialize();
      isControllerInitialized = true;
      notifyListeners();
    } catch (e) {
      print('Error initializing video controller: $e');
      isControllerInitialized = false;
      notifyListeners();
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void startTimer(int restTime) {
    _timer?.cancel();
    remainingSeconds = restTime;
    totalTime = restTime; // 👈 Add this line to keep total time

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        notifyListeners();
      } else {
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void previousVideo() {
    if (selectedVideo > 0) {
      selectedVideo--;
      selectedbtn = 0;
    }
    notifyListeners();
  }

  void nextVideo(List<VideoModel> allVideos, BuildContext context) {
    if (selectedVideo < allVideos.length - 1) {
      selectedVideo++;
      selectedbtn = 0;
      notifyListeners();
    }
  }

  void selectVersionChip(int index) {
    selectedbtn = index;
    notifyListeners();
  }

  void selectVideoItem(int index) {
    selectedVideo = index;
    notifyListeners();
  }

  List<VideoModel> extractAllVideos(dynamic modelData) {
    if (modelData is WorkoutModel) {
      return modelData.categorizedVideos?.values.expand((v) => v).toList() ??
          [];
    } else if (modelData is ProgramModel) {
      List<VideoModel> allVideos = [];

      for (WorkoutModel workout in modelData.listOfWorkouts ?? []) {
        final categorized = workout.categorizedVideos;

        if (categorized != null) {
          for (List<VideoModel> videoList in categorized.values) {
            for (VideoModel video in videoList) {
              allVideos.add(video);
            }
          }
        }
      }

      return allVideos;
    }

    return [];
  }

  Future<void> preloadThumbnails(List<VideoModel> videos) async {
    for (var video in videos) {
      if (!thumbnailCache.containsKey(video.url)) {
        final thumb = await VideoThumbnail.thumbnailData(
          video: video.url,
          imageFormat: ImageFormat.PNG,
          maxWidth: 128,
          quality: 25,
        );
        thumbnailCache[video.url] = thumb;

        // Notify after each thumbnail is loaded 👇
        notifyListeners();
      }
    }
  }
}
