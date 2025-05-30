import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String? userId;
  final String? contentId;
  final String? contentType; // e.g. 'program', 'workout', 'creator', 'company'
  final String? name; // optional name (e.g. creator name)
  final double? rating;
  final String? feedbackMessage;
  final String? email;
  final String? suggestion;
  final String? imageUrl;
  final DateTime? timestamp;

  FeedbackModel({
    this.userId,
    this.contentId,
    this.contentType,
    this.name,
    this.rating,
    this.feedbackMessage,
    this.email,
    this.suggestion,
    this.imageUrl,
    this.timestamp,
  });

  FeedbackModel copyWith({
    String? userId,
    String? contentId,
    String? contentType,
    String? name,
    double? rating,
    String? feedbackMessage,
    String? email,
    String? suggestion,
    String? imageUrl,
    DateTime? timestamp,
  }) {
    return FeedbackModel(
      userId: userId ?? this.userId,
      contentId: contentId ?? this.contentId,
      contentType: contentType ?? this.contentType,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      feedbackMessage: feedbackMessage ?? this.feedbackMessage,
      email: email ?? this.email,
      suggestion: suggestion ?? this.suggestion,
      imageUrl: imageUrl ?? this.imageUrl,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      userId: json['userId'],
      contentId: json['contentId'],
      contentType: json['contentType'],
      name: json['name'],
      rating: (json['rating'] as num?)?.toDouble(),
      feedbackMessage: json['feedbackMessage'],
      email: json['email'],
      suggestion: json['suggestion'],
      imageUrl: json['imageUrl'],
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'contentId': contentId,
      'contentType': contentType,
      'name': name,
      'rating': rating,
      'feedbackMessage': feedbackMessage,
      'email': email,
      'suggestion': suggestion,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
    };
  }
}
