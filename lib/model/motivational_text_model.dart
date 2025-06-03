import 'package:cloud_firestore/cloud_firestore.dart';

class MotivationalTextModel {
  final String? id;
  final String? title;
  final String? description;
  final String? userId;
  final DateTime? createdAt;

  MotivationalTextModel({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.createdAt,
  });

  MotivationalTextModel copyWith({
    String? id,
    String? title,
    String? description,
    String? userId,
    DateTime? createdAt,
  }) {
    return MotivationalTextModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory MotivationalTextModel.fromJson(
    Map<String, dynamic> json, {
    String? id,
  }) {
    return MotivationalTextModel(
      id: id,
      title: json['title'],
      description: json['description'],
      userId: json['userId'],
      createdAt: (json['createdAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'userId': userId,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }
}
