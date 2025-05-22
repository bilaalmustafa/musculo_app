class UserModel {
  final String? name;
  final String? gender;
  final int? age;
  final String? userid;
  final String? levelOfFitness;
  final String? email;
  final List<Map<String, dynamic>>? listOfPrograms;
  final List<Map<String, dynamic>>? listOfWorkouts;
  final String? status;

  UserModel({
    this.name,
    this.gender,
    this.age,
    this.userid,
    this.levelOfFitness,
    this.email,
    this.listOfPrograms,
    this.listOfWorkouts,
    this.status,
  });

  UserModel copyWith({
    String? name,
    String? gender,
    int? age,
    String? userid,
    String? levelOfFitness,
    String? email,
    List<Map<String, dynamic>>? listOfPrograms,
    List<Map<String, dynamic>>? listOfWorkouts,
    String? status,
  }) {
    return UserModel(
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      userid: userid ?? this.userid,
      levelOfFitness: levelOfFitness ?? this.levelOfFitness,
      email: email ?? this.email,
      listOfPrograms: listOfPrograms ?? this.listOfPrograms,
      listOfWorkouts: listOfWorkouts ?? this.listOfWorkouts,
      status: status ?? this.status,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      gender: json['gender'],
      age: json['age'],
      userid: json['userid'],
      levelOfFitness: json['level_of_fitness'],
      email: json['email'],
      listOfPrograms: List<Map<String, dynamic>>.from(json['list_of_programs'] ?? []),
      listOfWorkouts: List<Map<String, dynamic>>.from(json['list_of_workouts'] ?? []),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'gender': gender,
      'age': age,
      'userid': userid,
      'level_of_fitness': levelOfFitness,
      'email': email,
      'list_of_programs': listOfPrograms,
      'list_of_workouts': listOfWorkouts,
      'status': status,
    };
  }
}
