import 'package:musculo_app/model/programs_%20model.dart';
import 'package:musculo_app/model/workouts_model.dart';

enum Gender { male, female, other }

enum FitnessLevel { beginner, intermediate, advanced }

enum UserStatus { active, inactive, suspended }

class UserModel {
  final String? id;
  final String? name;
  final String? gender;
  final String? profileImageUrl;
  final int? age;
  final String? userId; // Changed from userid for better naming
  final String? levelOfFitness;
  final String? email;
  final List<ProgramModel>
  listOfPrograms; // Non-nullable with default empty list
  final List<WorkoutModel>
  listOfWorkouts; // Non-nullable with default empty list
  final UserStatus? status;
  final int?
  finishedWorkouts; // Changed from String to int for better type safety
  final int? spentMinutes; // Changed from String to int and better naming
  final DateTime?
  dateOfBirth; // Changed from String to DateTime for better type safety

  const UserModel({
    this.id,
    this.name,
    this.gender,
    this.age,
    this.profileImageUrl,
    this.userId,
    this.levelOfFitness,
    this.email,
    this.listOfPrograms = const [], // Default empty list
    this.listOfWorkouts = const [], // Default empty list
    this.status,
    this.finishedWorkouts,
    this.spentMinutes,
    this.dateOfBirth,
  });

  UserModel copyWith({
    String? name,
    String? gender,
    String? profileImageUrl,
    int? age,
    String? userId,
    String? levelOfFitness,
    String? email,
    List<ProgramModel>? listOfPrograms,
    List<WorkoutModel>? listOfWorkouts,
    UserStatus? status,
    int? finishedWorkouts,
    int? spentMinutes,
    DateTime? dateOfBirth,
  }) {
    return UserModel(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      userId: userId ?? this.userId,
      levelOfFitness: levelOfFitness ?? this.levelOfFitness,
      email: email ?? this.email,
      listOfPrograms: listOfPrograms ?? this.listOfPrograms,
      listOfWorkouts: listOfWorkouts ?? this.listOfWorkouts,
      status: status ?? this.status,
      finishedWorkouts: finishedWorkouts ?? this.finishedWorkouts,
      spentMinutes: spentMinutes ?? this.spentMinutes,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return UserModel(
      id: json['id'],
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      age: json['age'] as int?,
      userId: json['userid'] as String?, // Updated key name
      levelOfFitness: json['level_of_fitness'] as String?,
      email: json['email'] as String?,
      listOfPrograms: _parsePrograms(json['list_of_programs']),
      listOfWorkouts: _parseWorkouts(json['list_of_workouts']),
      status: _parseUserStatus(json['status']),
      finishedWorkouts: _parseIntFromDynamic(json['finishedwork']),
      spentMinutes: _parseIntFromDynamic(json['spentMins']),
      dateOfBirth: _parseDateFromString(json['dateOB']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'profileImageUrl': profileImageUrl,
      'age': age,
      'userid': userId, // Updated key name
      'level_of_fitness': levelOfFitness,
      'email': email,
      'list_of_programs': listOfPrograms.map((e) => e.toJson()).toList(),
      'list_of_workouts': listOfWorkouts.map((e) => e.toJson()).toList(),
      'status': status?.name,
      'finishedwork': finishedWorkouts,
      'spentMins': spentMinutes,
      'dateOB': dateOfBirth?.toIso8601String(),
    };
  }

  // Helper methods for parsing
  static Gender? _parseGender(dynamic value) {
    if (value == null) return null;
    final genderStr = value.toString().toLowerCase();
    switch (genderStr) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      case 'other':
        return Gender.other;
      default:
        return null;
    }
  }

  static FitnessLevel? _parseFitnessLevel(dynamic value) {
    if (value == null) return null;
    final levelStr = value.toString().toLowerCase();
    switch (levelStr) {
      case 'beginner':
        return FitnessLevel.beginner;
      case 'intermediate':
        return FitnessLevel.intermediate;
      case 'advanced':
        return FitnessLevel.advanced;
      default:
        return null;
    }
  }

  static UserStatus? _parseUserStatus(dynamic value) {
    if (value == null) return null;
    final statusStr = value.toString().toLowerCase();
    switch (statusStr) {
      case 'active':
        return UserStatus.active;
      case 'inactive':
        return UserStatus.inactive;
      case 'suspended':
        return UserStatus.suspended;
      default:
        return null;
    }
  }

  static List<ProgramModel> _parsePrograms(dynamic programsJson) {
    if (programsJson == null || programsJson is! List) return const [];
    try {
      return programsJson
          .map((e) => ProgramModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return const [];
    }
  }

  static List<WorkoutModel> _parseWorkouts(dynamic workoutsJson) {
    if (workoutsJson == null || workoutsJson is! List) return const [];
    try {
      return workoutsJson
          .map((e) => WorkoutModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return const [];
    }
  }

  static int? _parseIntFromDynamic(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  static DateTime? _parseDateFromString(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.name == name &&
        other.gender == gender &&
        other.age == age &&
        other.userId == userId &&
        other.levelOfFitness == levelOfFitness &&
        other.email == email &&
        other.status == status &&
        other.finishedWorkouts == finishedWorkouts &&
        other.spentMinutes == spentMinutes &&
        other.dateOfBirth == dateOfBirth;
  }

  @override
  int get hashCode {
    return Object.hash(
      name,
      gender,
      age,
      userId,
      levelOfFitness,
      email,
      status,
      finishedWorkouts,
      spentMinutes,
      dateOfBirth,
    );
  }

  @override
  String toString() {
    return 'UserModel('
        'name: $name, '
        'gender: $gender, '
        'profileImageUrl: $profileImageUrl,'
        'age: $age, '
        'userId: $userId, '
        'levelOfFitness: $levelOfFitness, '
        'email: $email, '
        'programsCount: ${listOfPrograms.length}, '
        'workoutsCount: ${listOfWorkouts.length}, '
        'status: $status, '
        'finishedWorkouts: $finishedWorkouts, '
        'spentMinutes: $spentMinutes, '
        'dateOfBirth: $dateOfBirth'
        ')';
  }
}

// import 'package:musculo_app/model/programs.dart';
// import 'package:musculo_app/model/workouts.dart';

// class UserModel {
//   final String? name;
//   final String? gender;
//   final int? age;
//   final String? userid;
//   final String? levelOfFitness;
//   final String? email;
//   final List<ProgramModel>? listOfPrograms;
//   final List<WorkoutModel>? listOfWorkouts;
//   final String? status;
//   final String? finishedwork;
//   final String? spentMins;
//   final String? dateOB;

//   UserModel({
//     this.name,
//     this.gender,
//     this.age,
//     this.userid,
//     this.levelOfFitness,
//     this.email,
//     this.listOfPrograms,
//     this.listOfWorkouts,
//     this.status,
//     this.finishedwork,
//     this.spentMins,
//     this.dateOB,
//   });

//   UserModel copyWith({
//     String? name,
//     String? gender,
//     int? age,
//     String? userid,
//     String? levelOfFitness,
//     String? email,
//     List<ProgramModel>? listOfPrograms,
//     List<WorkoutModel>? listOfWorkouts,
//     String? status,
//     String? finishedwork,
//     String? spentMins,
//     String? dateOB,
//   }) {
//     return UserModel(
//       name: name ?? this.name,
//       gender: gender ?? this.gender,
//       age: age ?? this.age,
//       userid: userid ?? this.userid,
//       levelOfFitness: levelOfFitness ?? this.levelOfFitness,
//       email: email ?? this.email,
//       listOfPrograms: listOfPrograms ?? this.listOfPrograms,
//       listOfWorkouts: listOfWorkouts ?? this.listOfWorkouts,
//       status: status ?? this.status,
//       finishedwork: finishedwork ?? this.finishedwork,
//       spentMins: spentMins ?? this.spentMins,

//       dateOB: dateOB ?? this.dateOB,
//     );
//   }

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       name: json['name'],
//       gender: json['gender'],
//       age: json['age'],
//       userid: json['userid'],
//       levelOfFitness: json['level_of_fitness'],
//       email: json['email'],
//       listOfPrograms:
//           json['list_of_programs'] != null
//               ? List<ProgramModel>.from(
//                 json['list_of_programs'].map((e) => ProgramModel.fromJson(e)),
//               )
//               : [],
//       listOfWorkouts:
//           json['list_of_workouts'] != null
//               ? List<WorkoutModel>.from(
//                 json['list_of_workouts'].map((e) => WorkoutModel.fromJson(e)),
//               )
//               : [],
//       status: json['status'],
//       finishedwork: json['finishedwork'],
//       spentMins: json['spentMins'],

//       dateOB: json['dateOB'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'gender': gender,
//       'age': age,
//       'userid': userid,
//       'level_of_fitness': levelOfFitness,
//       'email': email,
//       'list_of_programs': listOfPrograms?.map((e) => e.toJson()).toList(),
//       'list_of_workouts': listOfWorkouts?.map((e) => e.toJson()).toList(),
//       'status': status,
//       'finishedwork': finishedwork,
//       'spentMins': spentMins,
//       'dateOB': dateOB,
//     };
//   }
// }
