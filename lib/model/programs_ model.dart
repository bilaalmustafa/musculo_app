import 'package:musculo_app/model/workouts_model.dart';

class ProgramModel {
  final String? userId;
  String? programId;
  final String? creatorName;
  final String? programName;
  final String? typeOf;
  final String? levelOf;
  final int? duration;
  final int? timeAWeek;
  final List<String>? dayAWeek;
  final String? intended;
  final double? price;
  final int? totalTime;
  final double? rating;
  final int? ratingCount;
  final List<String>? review;

  final List<WorkoutModel>? listOfWorkouts;

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
    this.listOfWorkouts,
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
      dayAWeek:
          (json['dayAWeek'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList(),
      intended: json['intended'],
      price: json["price"],
      totalTime: json["totalTime"],
      listOfWorkouts:
          (json['listOfWorkouts'] as List<dynamic>?)
              ?.map((e) => WorkoutModel.fromJson(e))
              .toList(),
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
      'listOfWorkouts': listOfWorkouts?.map((e) => e.toJson()).toList(),
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
    double? price,
    int? totalTime,
    double? rating,
    int? ratingCount,
    List<String>? review,
    List<WorkoutModel>? listOfWorkouts,
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
      listOfWorkouts: listOfWorkouts ?? this.listOfWorkouts,
    );
  }
}
