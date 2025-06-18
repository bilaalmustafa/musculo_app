import 'package:hive/hive.dart';

part 'video_model.g.dart';

@HiveType(typeId: 1) // Ensure this ID is unique across all your models
class VideoModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String url;

  @HiveField(2)
  int durationInSeconds; // Hive doesn't support Duration directly

  @HiveField(3)
  String? thumbnailPath;

  @HiveField(4)
  int intervalSeconds;

  @HiveField(5)
  int restTime;

  @HiveField(6)
  List<VideoModel> versionList; // Recursive Hive support OK if registered

  VideoModel({
    required this.name,
    required this.url,
    Duration? duration,
    this.thumbnailPath,
    this.intervalSeconds = 30,
    this.restTime = 10,
    required this.versionList,
  }) : durationInSeconds = duration?.inSeconds ?? 0;

  Duration get duration => Duration(seconds: durationInSeconds);

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      name: json['name'],
      url: json['url'],
      duration: Duration(seconds: json['duration']),
      thumbnailPath: json['thumbnailPath'],
      intervalSeconds: json['intervalSeconds'] ?? 30,
      restTime: json['restTime'] ?? 10,
      versionList:
          (json['versionList'] as List<dynamic>? ?? [])
              .map((v) => VideoModel.fromJson(v as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
      'duration': duration.inSeconds,
      'thumbnailPath': thumbnailPath,
      'intervalSeconds': intervalSeconds,
      'restTime': restTime,
      'versionList': versionList.map((v) => v.toJson()).toList(),
    };
  }

  VideoModel copyWith({
    String? name,
    String? url,
    Duration? duration,
    String? thumbnailPath,
    int? intervalSeconds,
    int? restTime,
    List<VideoModel>? versionList,
  }) {
    return VideoModel(
      name: name ?? this.name,
      url: url ?? this.url,
      duration: duration ?? this.duration,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      intervalSeconds: intervalSeconds ?? this.intervalSeconds,
      restTime: restTime ?? this.restTime,
      versionList: versionList ?? this.versionList,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          url == other.url &&
          intervalSeconds == other.intervalSeconds;

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
