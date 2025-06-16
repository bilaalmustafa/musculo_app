import 'package:musculo_app/model/workouts_model.dart';

class ProgramModel {
  final String? id;
  final String? creatorName;
  final String? programName;
  final String? typeOf;
  final String? levelOf;
  final int? duration;
  final String? timeAWeek;
  final String? dayAWeek;
  final String? intended;

  final List<WorkoutModel>? listOfWorkouts;

  ProgramModel({
    this.id,
    this.creatorName,
    this.programName,
    this.typeOf,
    this.levelOf,
    this.duration,
    this.timeAWeek,
    this.dayAWeek,
    this.intended,

    this.listOfWorkouts,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      id: json['id'],
      creatorName: json['creatorName'],
      programName: json['programName'],
      typeOf: json['typeOf'],
      levelOf: json['levelOf'],
      duration:
          json['duration'] is int
              ? json['duration']
              : int.tryParse(json['duration'].toString()) ?? 0,
      timeAWeek: json['timeAWeek'],
      dayAWeek: json['dayAWeek'],
      intended: json['intended'],
      listOfWorkouts:
          (json['listOfWorkouts'] as List<dynamic>?)
              ?.map((e) => WorkoutModel.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "creatorName": creatorName,
      'programName': programName,
      'typeOf': typeOf,
      'levelOf': levelOf,
      'duration': duration,
      'timeAWeek': timeAWeek,
      'dayAWeek': dayAWeek,
      "intended": intended,
      'listOfWorkouts': listOfWorkouts?.map((e) => e.toJson()).toList(),
    };
  }

  ProgramModel copyWith({
    String? id,
    String? creatorName,
    String? programName,
    String? typeOf,
    String? levelOf,
    int? duration,
    String? timeAWeek,
    String? dayAWeek,
    String? intended,
    List<WorkoutModel>? listOfWorkouts,
  }) {
    return ProgramModel(
      id: id ?? this.id,
      creatorName: creatorName ?? this.creatorName,
      programName: programName ?? this.programName,
      typeOf: typeOf ?? this.typeOf,
      levelOf: levelOf ?? this.levelOf,
      duration: duration ?? this.duration,
      timeAWeek: timeAWeek ?? this.timeAWeek,
      dayAWeek: dayAWeek ?? this.dayAWeek,
      intended: intended ?? this.intended,

      listOfWorkouts: listOfWorkouts ?? this.listOfWorkouts,
    );
  }
}
