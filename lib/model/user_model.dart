import 'package:musculo_app/model/programs_model.dart';
import 'package:musculo_app/model/sold_model.dart';
import 'package:musculo_app/model/workouts_model.dart';

// enum Gender { male, female, other }

// enum FitnessLevel { beginner, intermediate, advanced }

// enum UserStatus { active, inactive, suspended }

enum UserStatus { active, inactive, suspended }

class UserModel {
  final String? name;
  final String? role;
  final String? gender;
  final String? profileImageUrl;
  final int? age;
  final String? userId;
  final String? levelOfFitness;
  final String? email;
  final List<ProgramModel> listOfPrograms;
  final List<WorkoutModel> listOfWorkouts;
  final UserStatus? status;
  final int? finishedWorkouts;
  final int? spentMinutes;
  final DateTime? dateOfBirth;
  final String? subPlane;
  final List<SoldModel> sold;
  final double? rating;
  final List<String> review;
  final int? countRating;
  final double? withdraw;
  final DateTime? subscriptionDate;
  final String? overviewText;
  final String? experienceText;
  final String? goalText;
  final String? favExercise;
  final DateTime? createdAt;

  const UserModel({
    this.name,
    this.role,
    this.gender,
    this.age,
    this.profileImageUrl,
    this.userId,
    this.levelOfFitness,
    this.email,
    this.listOfPrograms = const [],
    this.listOfWorkouts = const [],
    this.status,
    this.finishedWorkouts,
    this.spentMinutes,
    this.dateOfBirth,
    this.subPlane,
    this.sold = const [],
    this.rating,
    this.review = const [],
    this.countRating,
    this.withdraw,
    this.subscriptionDate,
    this.overviewText,
    this.experienceText,
    this.goalText,
    this.favExercise,
    this.createdAt,
  });

  UserModel copyWith({
    String? name,
    String? role,
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
    String? subPlane,
    List<SoldModel>? sold,
    double? rating,
    List<String>? review,
    int? countRating,
    double? withdraw,
    DateTime? subscriptionDate,
    String? overviewText,
    String? experienceText,
    String? goalText,
    String? favExercise,
    DateTime? createdAt,
  }) {
    return UserModel(
      name: name ?? this.name,
      role: role ?? this.role,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      userId: userId ?? this.userId,
      levelOfFitness: levelOfFitness ?? this.levelOfFitness,
      email: email ?? this.email,
      listOfPrograms: listOfPrograms ?? this.listOfPrograms,
      listOfWorkouts: listOfWorkouts ?? this.listOfWorkouts,
      status: status ?? this.status,
      finishedWorkouts: finishedWorkouts ?? this.finishedWorkouts,
      spentMinutes: spentMinutes ?? this.spentMinutes,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      subPlane: subPlane ?? this.subPlane,
      sold: sold ?? this.sold,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      countRating: countRating ?? this.countRating,
      withdraw: withdraw ?? this.withdraw,
      subscriptionDate: subscriptionDate ?? this.subscriptionDate,
      overviewText: overviewText ?? this.overviewText,
      experienceText: experienceText ?? this.experienceText,
      goalText: goalText ?? this.goalText,
      favExercise: favExercise ?? this.favExercise,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return UserModel(
      name: json['name'] as String?,
      role: json['role'] as String?,
      gender: json['gender'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      age: json['age'] as int?,
      userId: json['userid'] as String?,
      levelOfFitness: json['level_of_fitness'] as String?,
      email: json['email'] as String?,
      listOfPrograms: _parsePrograms(json['list_of_programs']),
      listOfWorkouts: _parseWorkouts(json['list_of_workouts']),
      status: _parseUserStatus(json['status']),
      finishedWorkouts: _parseIntFromDynamic(json['finishedwork']),
      spentMinutes: _parseIntFromDynamic(json['spentMins']),
      dateOfBirth: _parseDateFromString(json['dateOB']),
      subPlane: json['subPlane'] as String?,
       sold: _parseSoldList(json['sold']),
      rating: (json['rating'] as num?)?.toDouble(),
      review:
          (json['review'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      countRating: json['countRating'] as int?,
      withdraw: (json['withdraw'] as num?)?.toDouble(),
      subscriptionDate: _parseDateFromString(json['subscriptionDate']),
      overviewText: json['overviewText'] as String?,
      experienceText: json['experienceText'] as String?,
      goalText: json['goalText'] as String?,
      favExercise: json['favExercise'] as String?,
      createdAt: _parseDateFromString(json['createdAt']) ?? DateTime.now(),
    );
  }

  static List<SoldModel> _parseSoldList(dynamic soldJson) {
    if (soldJson == null || soldJson is! List) return const [];
    return soldJson.map((e) => SoldModel.fromJson(e)).toList();
  }

  static List<ProgramModel> _parsePrograms(dynamic programsJson) {
    if (programsJson == null || programsJson is! List) return const [];
    return programsJson.map((e) => ProgramModel.fromJson(e)).toList();
  }

  static List<WorkoutModel> _parseWorkouts(dynamic workoutsJson) {
    if (workoutsJson == null || workoutsJson is! List) return const [];
    return workoutsJson.map((e) => WorkoutModel.fromJson(e)).toList();
  }

  static int? _parseIntFromDynamic(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static DateTime? _parseDateFromString(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static UserStatus? _parseUserStatus(dynamic value) {
    if (value == null) return null;
    switch (value.toString().toLowerCase()) {
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

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt?.toIso8601String(),
      'name': name,
      'role': role,
      'gender': gender,
      'profileImageUrl': profileImageUrl,
      'age': age,
      'userid': userId,
      'level_of_fitness': levelOfFitness,
      'email': email,
      'list_of_programs': listOfPrograms.map((e) => e.toJson()).toList(),
      'list_of_workouts': listOfWorkouts.map((e) => e.toJson()).toList(),
      'status': status?.name,
      'finishedwork': finishedWorkouts,
      'spentMins': spentMinutes,
      'dateOB': dateOfBirth?.toIso8601String(),
      'subPlane': subPlane,
      'sold': sold.map((e) => e.toJson()).toList(),
      'rating': rating,
      'review': review,
      'countRating': countRating,
      'withdraw': withdraw,
      'subscriptionDate': subscriptionDate?.toIso8601String(),
      'overviewText': overviewText,
      'experienceText': experienceText,
      'goalText': goalText,
      'favExercise': favExercise,
    };
  }
}


