import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String? userId;
  final String? contentId;
  final String? contentType; // e.g. 'program', 'workout', 'creator',
  final String? name; // e.g. workout, creator or program name
  final String? otherReason; // custom reason input
  final String? reason; // selected predefined reason
  final String? email;
  final String? note; // report or suggestion note
  final String? image; // image URL
  final DateTime? timeStamp;

  ReportModel({
    this.userId,
    this.contentId,
    this.contentType,
    this.name,
    this.otherReason,
    this.reason,
    this.email,
    this.note,
    this.image,
    this.timeStamp,
  });

  ReportModel copyWith({
    String? userId,
    String? contentId,
    String? contentType,
    String? name,
    String? otherReason,
    String? reason,
    String? email,
    String? note,
    String? image,
    DateTime? timeStamp,
  }) {
    return ReportModel(
      userId: userId ?? this.userId,
      contentId: contentId ?? this.contentId,
      contentType: contentType ?? this.contentType,
      name: name ?? this.name,
      otherReason: otherReason ?? this.otherReason,
      reason: reason ?? this.reason,
      email: email ?? this.email,
      note: note ?? this.note,
      image: image ?? this.image,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      userId: json['userId'],
      contentId: json['contentId'],
      contentType: json['contentType'],
      name: json['name'],
      otherReason: json['otherReason'],
      reason: json['reason'],
      email: json['email'],
      note: json['note'],
      image: json['image'],
      timeStamp: (json['timeStamp'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'contentId': contentId,
      'contentType': contentType,
      'name': name,
      'otherReason': otherReason,
      'reason': reason,
      'email': email,
      'note': note,
      'image': image,
      'timeStamp': timeStamp,
    };
  }
}
