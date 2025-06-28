import 'package:cloud_firestore/cloud_firestore.dart';

class SoldModel {
  final String userId;
  final String contentId;
  final String contentName;
  final String type;
  final bool packegeMode;
  final double contentPrice;
  final DateTime buyDate;

  SoldModel({
    required this.userId,
    required this.contentId,
    required this.contentName,
    required this.type,
    required this.packegeMode,
    required this.contentPrice,
    required this.buyDate,
  });

 
  factory SoldModel.fromJson(Map<String, dynamic> json) {
    return SoldModel(
      userId: json['userId'] ?? '',
      contentId: json['contentId'] ?? '',
      contentName: json['contentName'] ?? '',
      type: json['type'] ?? '',
      packegeMode: json['packegeMode'] ?? false,
      contentPrice: (json['contentPrice'] ?? 0).toDouble(),
      buyDate: (json['buyDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// ✅ JSON Serialization
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'contentId': contentId,
      'contentName': contentName,
      'type': type,
      'packegeMode': packegeMode,
      'contentPrice': contentPrice,
      'buyDate': buyDate,
    };
  }

 
  SoldModel copyWith({
    String? userId,
    String? contentId,
    String? contentName,
    String? type,
    bool? packegeMode,
    double? contentPrice,
    DateTime? buyDate,
  }) {
    return SoldModel(
      userId: userId ?? this.userId,
      contentId: contentId ?? this.contentId,
      contentName: contentName ?? this.contentName,
      type: type ?? this.type,
      packegeMode: packegeMode ?? this.packegeMode,
      contentPrice: contentPrice ?? this.contentPrice,
      buyDate: buyDate ?? this.buyDate,
    );
  }
}
