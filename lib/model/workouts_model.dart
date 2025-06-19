// 1. First, update your WorkoutModel to include an ID field for favorites
import 'package:musculo_app/model/video_model.dart';
import 'package:hive/hive.dart';
part 'workouts_model.g.dart';

@HiveType(typeId: 0) // Add this for Hive
class WorkoutModel extends HiveObject {
  @HiveField(0)
  final String? workoutId; // Add unique ID for the workout

  @HiveField(1)
  final String? userId;

  @HiveField(2)
  final String? creatorName;

  @HiveField(3)
  final String? workoutName;

  @HiveField(4)
  final String? workoutType;

  @HiveField(5)
  final List<String>? addedTo;

  @HiveField(6)
  final String? difficulty;

  @HiveField(7)
  final String? levelOf;

  @HiveField(8)
  final String? gender;

  @HiveField(9)
  final int? totalTime;

  @HiveField(10)
  final int? price;

  @HiveField(11)
  final DateTime? dateTime;

  @HiveField(12)
  final String? description;

  @HiveField(13)
  final Map<String, List<VideoModel>>? categorizedVideos;

  WorkoutModel({
    this.workoutId,
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
      workoutId: json['workoutId'] as String?,
      userId: json['userId'] as String?,
      creatorName: json['creatorName'] as String?,
      workoutName: json['workoutName'] as String?,
      workoutType: json['workoutType'] as String?,
      addedTo:
          json['addedTo'] != null
              ? List<String>.from(json['addedTo'] as List)
              : null,
      difficulty: json['difficulty'] as String?,
      levelOf: json['levelOf'] as String?,
      gender: json['gender'] as String?,
      totalTime: json['totalTime'] as int?,
      price: json['price'] as int?,
      dateTime:
          json['dateTime'] != null ? DateTime.tryParse(json['dateTime']) : null,
      description: json['description'] as String?,
      categorizedVideos: (json['categorizedVideos'] as Map<String, dynamic>?)
          ?.map(
            (key, value) => MapEntry(
              key,
              (value as List)
                  .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
                  .toList(),
            ),
          ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workoutId': workoutId,
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
    String? workoutId,
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
      workoutId: workoutId ?? this.workoutId,
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
