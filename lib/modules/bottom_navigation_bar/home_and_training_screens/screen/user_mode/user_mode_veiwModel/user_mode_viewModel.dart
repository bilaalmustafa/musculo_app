import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/routes.dart';
import 'package:musculo_app/model/video_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UserModeViewmodel extends ChangeNotifier {
  int selectedbtn = 0;
  int selectedVideo = 0;
  final Map<String, Uint8List?> thumbnailCache = {};
  Timer? _timer;
  int remainingSeconds = 0;
 int totalTime = 0;
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


  // void startTimer(int restTime) {
  //   _timer?.cancel();
  //   remainingSeconds = restTime;

  //   _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     if (remainingSeconds > 0) {
  //       remainingSeconds--;
  //       notifyListeners();
  //     } else {
  //       timer.cancel();
  //     }
  //   });
  // }

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
