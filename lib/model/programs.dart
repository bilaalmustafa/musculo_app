import 'package:musculo_app/model/workouts_model.dart';

class ProgramModel {
  final String? id;
  final String? programName;
  final String? typeOf;
  final String? levelOf;
  final int? duration;
  final String? timeAWeek;
  final String? dayAWeek;
  final List<WorkoutModel>? listOfWorkouts;

  ProgramModel({
    this.id,
    this.programName,
    this.typeOf,
    this.levelOf,
    this.duration,
    this.timeAWeek,
    this.dayAWeek,
    this.listOfWorkouts,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json, ) {
    return ProgramModel(
      id: json['id'],
      programName: json['programName'],
      typeOf: json['typeOf'],
      levelOf: json['levelOf'],
      duration:
          json['duration'] is int
              ? json['duration']
              : int.tryParse(json['duration'].toString()) ?? 0,
      timeAWeek: json['timeAWeek'],
      dayAWeek: json['dayAWeek'],
      listOfWorkouts: (json['listOfWorkouts'] as List<dynamic>?)
          ?.map((e) => WorkoutModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'programName': programName,
      'typeOf': typeOf,
      'levelOf': levelOf,
      'duration': duration,
      'timeAWeek': timeAWeek,
      'dayAWeek': dayAWeek,
      'listOfWorkouts': listOfWorkouts?.map((e) => e.toJson()).toList(),
    };
  }

  ProgramModel copyWith({
    String? id,
    String? programName,
    String? typeOf,
    String? levelOf,
    int? duration,
    String? timeAWeek,
    String? dayAWeek,
     List<WorkoutModel>? listOfWorkouts,
  }) {
    return ProgramModel(
      id: id ?? this.id,
      programName: programName ?? this.programName,
      typeOf: typeOf ?? this.typeOf,
      levelOf: levelOf ?? this.levelOf,
      duration: duration ?? this.duration,
      timeAWeek: timeAWeek ?? this.timeAWeek,
      dayAWeek: dayAWeek ?? this.dayAWeek,
       listOfWorkouts: listOfWorkouts ?? this.listOfWorkouts,
    );
  }
}


