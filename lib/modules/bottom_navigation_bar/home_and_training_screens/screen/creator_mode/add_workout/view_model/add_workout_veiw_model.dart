import 'dart:async';
import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart'
    show FirebaseStorage, Reference;
import 'package:flutter/material.dart';
import 'package:musculo_app/core/config/injections.dart';
import 'package:musculo_app/core/services/creator_services.dart';

import 'package:musculo_app/model/video_model.dart';
import 'package:musculo_app/model/workouts_model.dart';
import 'package:path_provider/path_provider.dart';

import 'package:video_thumbnail/video_thumbnail.dart';

class AddWorkoutVeiwModel extends ChangeNotifier {
  StreamSubscription<VideoModel>? _videoSubscription;
  List<VideoModel> addVersionList = [];
  Map<String, List<VideoModel>> selectedVideos = {};
  final List<VideoModel> storagevideos = [];
  bool isvedioLoading = true;
  String? errorMessage;
  bool isLoading = false;
  List<VideoModel> selectedList = [];
  int currentSectionIndex = 0;
  String typeofworkout = "";
  String levelofworkout = "";
  bool isTypeofworkoutSelect = false;
  bool isLevelofworkoutslect = false;
  bool isSectionofWorkout = false;
  List<bool> sectionofWorkout = [false, false, false, false, false];
  final List<String> _sectionTitles = [
    "Warm up",
    "Extended warm up",
    "Workout",
    "Finisher",
    "Cool down",
  ];
  final List<String> selectedSections = [];
  double difficulty = 5;
  String? selected;
  String? gender;
  TextEditingController workoutNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime? selectedDate;
  final formKey = GlobalKey<FormState>();

  WorkoutModel? workoutModel;
  ////////  vesdioselecrtes
  void addSelectedVideo(String key, List<VideoModel> value) {
    selectedVideos[key] = value.map((video) => video.copyWith()).toList();
    notifyListeners();
  }

  void videoSelected(VideoModel index) {
    if (selectedList.contains(index)) {
      selectedList.remove(index);
    } else {
      selectedList.add(index);
    }
    notifyListeners();
  }

  void addversionvideo(VideoModel index) {
    if (addVersionList.contains(index)) {
      addVersionList.remove(index);
    } else {
      addVersionList.add(index);
    }
    notifyListeners();
  }

  int getTotalIntervalTimeInSeconds() {
    int total = 0;
    for (var videoList in selectedVideos.values) {
      for (var video in videoList) {
        total += video.intervalSeconds;
      }
    }
    return total;
  }

  void updateRestTime(String sectionTitle, int videoIndex, int newRestTime) {
    final videoList = selectedVideos[sectionTitle];
    if (videoList != null && videoIndex < videoList.length) {
      videoList[videoIndex].restTime = newRestTime;
      notifyListeners(); // 👈 Notifies the UI
    }
  }

  void updateintervelTime(String sectionTitle, int videoIndex, int newTime) {
    final videoList = selectedVideos[sectionTitle];
    if (videoList != null && videoIndex < videoList.length) {
      videoList[videoIndex].intervalSeconds = newTime;
      notifyListeners(); // 👈 Notifies the UI
    }
  }

  //////
  bool sectectedvideosvalidation() {
    if (selectedList.isNotEmpty) {
      addSelectedVideo(
        selectedSections[currentSectionIndex],
        List.from(selectedList),
      );
      if (currentSectionIndex < selectedSections.length - 1) {
        log("dataaaaa $selectedVideos");
        currentSectionIndex++;

        selectedList.clear();
        notifyListeners();
        return false;
      }

      return true;
    } else {
      return false;
    }
  }

  void selectadded(String value) {
    selected = value;
    notifyListeners();
  }

  void selectgender(String value) {
    gender = value;
    notifyListeners();
  }

  void typeofworkoutselect(String value) {
    typeofworkout = value;
    isTypeofworkoutSelect = false;

    notifyListeners();
  }

  void levelofworkoutselect(String value) {
    levelofworkout = value;
    isLevelofworkoutslect = false;

    notifyListeners();
  }

  bool sectionofWorkoutvalidate() {
    if (selectedSections.isNotEmpty) {
      notifyListeners();
      return true;
    } else {
      isSectionofWorkout = true;
      notifyListeners();
      return false;
    }
  }

  void sectionofWorkoutselct(bool value, int index) {
    sectionofWorkout[index] = value;
    isSectionofWorkout = false;
    String sectionTitle = _sectionTitles[index];
    if (value) {
      if (!selectedSections.contains(sectionTitle)) {
        selectedSections.add(sectionTitle);
      }
    } else {
      selectedSections.remove(sectionTitle);
    }
    notifyListeners();
  }

  void difficultySlider(double value) {
    difficulty = value;
    notifyListeners();
  }

  void dateSelecte(DateTime picked) {
    selectedDate = picked;
    dateController.text = "${picked.day}/${picked.month}/${picked.year}";
    notifyListeners();
  }

  bool validateAndSaveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  bool typeofWorkoutvalidate() {
    if (typeofworkout.isNotEmpty == true) {
      return true;
    } else {
      isTypeofworkoutSelect = true;
      notifyListeners();
      return false;
    }
  }

  bool levelofWorkoutvalidate() {
    if (levelofworkout.isNotEmpty == true) {
      return true;
    } else {
      isLevelofworkoutslect = true;
      notifyListeners();
      return false;
    }
  }

  Future<bool> creatediscoveryPost(
    String docId,
    String userId,
    String creatorName,
  ) async {
    isLoading = true;
    notifyListeners();
    WorkoutModel item = WorkoutModel(
      workoutId: docId,
      creatorName: creatorName,
      workoutName: workoutNameController.text,
      description: descriptionController.text,
      price: int.parse(priceController.text),
      dateTime: selectedDate ?? DateTime.now(),
      userId: userId,
      workoutType: typeofworkout,
      gender: gender,
      levelOf: levelofworkout,
      difficulty: difficulty.round().toString(),
      addedTo: selectedSections,
      totalTime: getTotalIntervalTimeInSeconds(),
      categorizedVideos: selectedVideos,
    );
    bool success = await instance<WorkoutServices>().createDiscovery(
      docId,
      item,
    );
    isLoading = false;
    workoutNameController.clear();
    descriptionController.clear();
    typeofworkout = "";
    gender = null;

    selected = null;
    sectionofWorkout = [false, false, false, false, false];
    selectedSections.clear();
    selectedVideos.clear();
    selectedDate = null;
    levelofworkout = "";
    notifyListeners();
    return success;
  }

  void addVersionToVideo(VideoModel targetVideo) {
    for (var version in addVersionList) {
      if (!targetVideo.versionList.contains(version)) {
        targetVideo.versionList.add(version);
      }
    }
    addVersionList.clear(); // Optionally clear after adding
    notifyListeners();
  }

  void loadVideos() async {
    final stream = fetchVideosWithDuration(batchSize: 5);
    _videoSubscription = stream.listen(
      (video) async {
        try {
          final thumbPath = await VideoThumbnail.thumbnailFile(
            video: video.url,
            thumbnailPath: (await getTemporaryDirectory()).path,
            imageFormat: ImageFormat.JPEG,
            quality: 75,
          );

          final videoWithThumb = VideoModel(
            name: video.name,
            url: video.url,
            duration: video.duration,
            thumbnailPath: thumbPath,
            versionList: [],
          );

          storagevideos.add(videoWithThumb);
          notifyListeners();
        } catch (e) {
          log("Error generating thumbnail for ${video.name}: $e");
        }
      },
      onError: (error) {
        errorMessage = 'Error loading videos.';
        notifyListeners();
      },
      onDone: () {
        isvedioLoading = false;
        notifyListeners();
      },
    );
  }

  Stream<VideoModel> fetchVideosWithDuration({int batchSize = 5}) async* {
    final storageRef = FirebaseStorage.instance;
    final listResult = await storageRef.ref('/all_exe').listAll();

    for (int i = 0; i < listResult.items.length; i += batchSize) {
      final batch = listResult.items.skip(i).take(batchSize);

      for (final item in batch) {
        try {
          final downloadUrl = await item.getDownloadURL();
          log('Video URL: $downloadUrl');

          // final controller = VideoPlayerController.networkUrl(
          //   Uri.parse(downloadUrl),
          // );

          // await controller.initialize().timeout(Duration(seconds: 10));
          // final duration = controller.value.duration;
          // await controller.dispose();
          // log('name video ${item.name}:');

          yield VideoModel(
            name: item.name.split('.').first,
            url: downloadUrl,
            duration: Duration.zero,
            versionList: [],
          );
        } catch (e) {
          log('Error processing video ${item.name}: $e');
        }
      }

      // Optional: small delay between batches to avoid overwhelming the system
      if (i + batchSize < listResult.items.length) {
        await Future.delayed(Duration(milliseconds: 100));
      }
    }
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  set searchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<VideoModel> get filteredVideos {
    if (_searchQuery.isEmpty) return storagevideos;
    return storagevideos
        .where(
          (video) =>
              video.name.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }
}
