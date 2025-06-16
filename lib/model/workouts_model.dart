import 'package:musculo_app/model/video_model.dart';

class WorkoutModel {
  final String? userId;
  final String? creatorName;
  final String? workoutName;
  final String? workoutType;
  final List<String>? addedTo;
  final String? difficulty;
  final String? levelOf;
  final String? gender;
  final int? totalTime;
  final int? price;
  final DateTime? dateTime;
  final String? description;
  final Map<String, List<VideoModel>>? categorizedVideos;

  WorkoutModel({
    this.userId,
    this.creatorName,
    this.workoutName,
    this.workoutType,
    this.addedTo,
    this.difficulty,
    this.levelOf,
    this.gender,
    this.totalTime,
    this.price,
    this.dateTime,
    this.description,
    this.categorizedVideos,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      userId: json['userId'] as String?,
      creatorName: json['creatorName'] as String?,
      workoutName: json['workoutName'] as String?,
      workoutType: json['workoutType'] as String?,
      addedTo: json['addedTo'] != null
          ? List<String>.from(json['addedTo'] as List)
          : null,
      difficulty: json['difficulty'] as String?,
      levelOf: json['levelOf'] as String?,
      gender: json['gender'] as String?,
      totalTime: json['totalTime'] as int?,
      price: json['price'] as int?,
      dateTime: json['dateTime'] != null
          ? DateTime.tryParse(json['dateTime'])
          : null,
      description: json['description'] as String?,
      categorizedVideos: (json['categorizedVideos'] as Map<String, dynamic>?)
          ?.map((key, value) => MapEntry(
                key,
                (value as List)
                    .map((e) =>
                        VideoModel.fromJson(e as Map<String, dynamic>))
                    .toList(),
              )),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'creatorName': creatorName,
      'workoutName': workoutName,
      'workoutType': workoutType,
      'addedTo': addedTo,
      'difficulty': difficulty,
      'levelOf': levelOf,
      'gender': gender,
      'totalTime': totalTime,
      'price': price,
      'dateTime': dateTime?.toIso8601String(),
      'description': description,
      'categorizedVideos': categorizedVideos?.map(
        (key, value) => MapEntry(key, value.map((v) => v.toJson()).toList()),
      ),
    };
  }

  WorkoutModel copyWith({
    String? userId,
    String? creatorName,
    String? workoutName,
    String? workoutType,
    List<String>? addedTo,
    String? difficulty,
    String? levelOf,
    String? gender,
    int? totalTime,
    int? price,
    DateTime? dateTime,
    String? description,
    Map<String, List<VideoModel>>? categorizedVideos,
  }) {
    return WorkoutModel(
      userId: userId ?? this.userId,
      creatorName: creatorName ?? this.creatorName,
      workoutName: workoutName ?? this.workoutName,
      workoutType: workoutType ?? this.workoutType,
      addedTo: addedTo ?? this.addedTo,
      difficulty: difficulty ?? this.difficulty,
      levelOf: levelOf ?? this.levelOf,
      gender: gender ?? this.gender,
      totalTime: totalTime ?? this.totalTime,
      price: price ?? this.price,
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
      categorizedVideos: categorizedVideos ?? this.categorizedVideos,
    );
  }
}
