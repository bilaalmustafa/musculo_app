import 'dart:async';
import 'dart:typed_data';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/injections.dart';

import 'package:musculo_app/core/services/user_service.dart';
import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/user_model.dart';
import 'package:musculo_app/model/video_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UserModeViewmodel extends ChangeNotifier {
  UserModel? userModel;
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
 bool isSwitch = false;


  void toggleSwitch(bool value) async {
    isSwitch = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSwitch', value);
  }
  Future<void> _loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    isSwitch = prefs.getBool('isSwitch') ?? false;
    notifyListeners();
  }



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

Future  <List<VideoModel>> extractAllVideos(dynamic modelData) async{
    if (modelData is WorkoutModel) {
      return modelData.categorizedVideos?.values.expand((v) => v).toList() ??
          [];
    } else if (modelData is ProgramModel) {
      List<VideoModel> allVideos = [];
    // Check if the list of workout IDs exists and is not empty
      if (modelData.listOfWorkoutIds != null && modelData.listOfWorkoutIds!.isNotEmpty) {
         for (String workoutId in modelData.listOfWorkoutIds!) {
       final workoutDoc= await FirebaseFirestore.instance.collection('discovery').doc(workoutId).get();
               // If the document exists, convert it to a WorkoutModel and extract its videos
       if (workoutDoc.exists) {
         final workout = WorkoutModel.fromJson(workoutDoc.data()!);
        final categorized = workout.categorizedVideos;
         if (categorized != null) {
            allVideos.addAll(categorized.values.expand((v) => v).toList());
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

  Future<void> updateUserWorkoutStats({
    required String userId,
    required int finishedWorkoutCount,
    required int minutesSpent,
  }) async {
    try {
      userModel ??= await instance<UserService>().getById(userId);
      final newFinishedWorkouts =
          (userModel?.finishedWorkouts ?? 0) + finishedWorkoutCount;
      final newSpentMinutes = (userModel?.spentMinutes ?? 0) + minutesSpent;
      final updatedUser = userModel!.copyWith(
        finishedWorkouts: newFinishedWorkouts,
        spentMinutes: newSpentMinutes,
      );
      await instance<UserService>().update(userId, updatedUser);
    } catch (e, stackTrace) {
      debugPrint("❌ Failed to update user workout stats: $e");
      debugPrint("Stack trace: $stackTrace");
    }
  }
}
