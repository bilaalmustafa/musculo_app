import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String? id;
  final String? userId;
  final String? contentId;
  final String? contentType; // e.g. 'program', 'workout', 'creator',
  final String? userName; // e.g. workout, creator or program name
  final String? otherReason; // custom reason input
  final String? reason; // selected predefined reason
  final String? email;
  final String? note; // report or suggestion note
  final String? image; // image URL
  final DateTime? timeStamp;
  final String? contentName;

  final double? rating;

  ReportModel({
    this.userId,
    this.id,
    this.contentId,
    this.contentType,
  
    this.otherReason,
    this.reason,
    this.email,
    this.note,
    this.image,
    this.timeStamp,
    this.contentName,
    this.userName,
    this.rating,
  });

  ReportModel copyWith({
    String? userId,
    String? contentId,
    String? contentType,
  
    String? otherReason,
    String? reason,
    String? email,
    String? note,
    String? image,
    DateTime? timeStamp,
       String? contentName,
   String? userName,
   double? rating,
  }) {
    return ReportModel(
      userId: userId ?? this.userId,
      contentId: contentId ?? this.contentId,
      contentType: contentType ?? this.contentType,
     
      otherReason: otherReason ?? this.otherReason,
      reason: reason ?? this.reason,
      email: email ?? this.email,
      note: note ?? this.note,
      image: image ?? this.image,
      timeStamp: timeStamp ?? this.timeStamp,
      contentName: contentName ?? this.contentName,
      userName: userName ?? this.userName,
      rating: rating ?? this.rating,
    );
  }

  factory ReportModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return ReportModel(
      id: json['id'],
      userId: json['userId'],
      contentId: json['contentId'],
      contentType: json['contentType'],
     
      otherReason: json['otherReason'],
      reason: json['reason'],
      email: json['email'],
      note: json['note'],
      image: json['image'],
      timeStamp: (json['timeStamp'] as Timestamp?)?.toDate(),
      contentName: json['contentName'],
      userName: json['userName'],
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'contentId': contentId,
      'contentType': contentType,
    
      'otherReason': otherReason,
      'reason': reason,
      'email': email,
      'note': note,
      'image': image,
      'timeStamp': timeStamp,
      'contentName': contentName,
      'userName': userName,
      'rating': rating,
    };
  }
}
