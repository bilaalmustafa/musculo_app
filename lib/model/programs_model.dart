import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:musculo_app/model/workouts_model.dart';

part 'programs_model.g.dart';

@HiveType(typeId: 2)
class ProgramModel extends HiveObject {
  @HiveField(0)
  String? userId;

  @HiveField(1)
  String? creatorName;

  @HiveField(2)
  String? programName;

  @HiveField(3)
  String? typeOf;

  @HiveField(4)
  String? levelOf;

  @HiveField(5)
  int? duration;

  @HiveField(6)
  int? timeAWeek;

  @HiveField(7)
  List<String>? dayAWeek;

  @HiveField(8)
  String? intended;

  @HiveField(9)
  num? price;

  @HiveField(10)
  int? totalTime;

  @HiveField(11)
  List<String>? listOfWorkoutIds;
  @HiveField(12)
  final double? rating;
  @HiveField(13)
  final int? ratingCount;
  @HiveField(14)
  final List<String>? review;
  @HiveField(15)
  String? programId;
  @HiveField(16)
  String? status; // "draft" or "published"
  @HiveField(17)
  DateTime? createdAt;
  @HiveField(18)
  DateTime? updatedAt;

  ProgramModel({
    this.userId,
    this.programId,
    this.creatorName,
    this.programName,
    this.typeOf,
    this.levelOf,
    this.duration,
    this.timeAWeek,
    this.dayAWeek,
    this.intended,
    this.price,
    this.totalTime,
    this.rating,
    this.ratingCount,
    this.review,
    this.listOfWorkoutIds,
    this.status = "published", // default
    this.createdAt,
    this.updatedAt,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      userId: json['userId'],
      programId: json["programId"],
      creatorName: json['creatorName'],
      programName: json['programName'],
      typeOf: json['typeOf'],
      levelOf: json['levelOf'],
      rating: json["rating"],
      ratingCount: json["ratingCount"],
      review:
          (json['review'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      duration:
          json['duration'] is int
              ? json['duration']
              : int.tryParse(json['duration'].toString()) ?? 0,
      timeAWeek: json['timeAWeek'],
      dayAWeek: (json['dayAWeek'] as List?)?.map((e) => e.toString()).toList(),
      intended: json['intended'],
      price: json["price"],
      totalTime: json["totalTime"],
      listOfWorkoutIds: (json['listOfWorkoutIds'] as List?)?.cast<String>(),
      status: json["status"] ?? "published",
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      "programId": programId,
      "creatorName": creatorName,
      'programName': programName,
      'typeOf': typeOf,
      'levelOf': levelOf,
      'duration': duration,
      'timeAWeek': timeAWeek,
      "rating": rating,
      "ratingCount": ratingCount,
      "review": review,
      'dayAWeek': dayAWeek?.map((e) => e.toString()).toList(),
      "intended": intended,
      "price": price,
      "totalTime": totalTime,
      'listOfWorkouts': listOfWorkoutIds,
      "status": status,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }

  ProgramModel copyWith({
    String? userId,
    String? programId,
    String? creatorName,
    String? programName,
    String? typeOf,
    String? levelOf,
    int? duration,
    int? timeAWeek,
    List<String>? dayAWeek,
    String? intended,
    num? price,
    int? totalTime,
    double? rating,
    int? ratingCount,
    List<String>? review,
    List<String>? listOfWorkoutIds,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProgramModel(
      userId: userId ?? this.userId,
      programId: programId ?? this.programId,
      creatorName: creatorName ?? this.creatorName,
      programName: programName ?? this.programName,
      typeOf: typeOf ?? this.typeOf,
      levelOf: levelOf ?? this.levelOf,
      duration: duration ?? this.duration,
      timeAWeek: timeAWeek ?? this.timeAWeek,
      dayAWeek: dayAWeek ?? this.dayAWeek,
      intended: intended ?? this.intended,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      ratingCount: ratingCount ?? this.ratingCount,
      review: review ?? this.review,
      totalTime: totalTime ?? this.totalTime,
      listOfWorkoutIds: listOfWorkoutIds ?? this.listOfWorkoutIds,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
