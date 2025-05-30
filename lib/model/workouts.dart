class WorkoutModel {
  final String id;
  final String workoutName;
  final String type;
  final String addedTo;
  final String difficulty;
  final String level;
  final String gender;
  final int totalTime;
  final int price;

  WorkoutModel({
    required this.id,
    required this.workoutName,
    required this.type,
    required this.addedTo,
    required this.difficulty,
    required this.level,
    required this.gender,
    required this.totalTime,
    required this.price,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      id: json['id'] ?? '',
      workoutName: json['workoutName'] ?? '',
      type: json['type'] ?? '',
      addedTo: json['addedTo'] ?? '',
      difficulty: json['difficulty'] ?? '',
      level: json['level'] ?? '',
      gender: json['gender'] ?? '',
      totalTime: json['totalTime'] ?? 0,
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workoutName': workoutName,
      'type': type,
      'addedTo': addedTo,
      'difficulty': difficulty,
      'level': level,
      'gender': gender,
      'totalTime': totalTime,
      'price': price,
    };
  }
}
