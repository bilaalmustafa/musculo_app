class VideoModel {
  final String name;
  final String url;
  final Duration duration;
  final String? thumbnailPath;
  int intervalSeconds;
  int restTime;
  List<VideoModel> versionList;

  VideoModel({
    required this.name,
    required this.url,
    required this.duration,
    this.thumbnailPath,
    this.intervalSeconds = 30,
    this.restTime = 10,
    required this.versionList,
  });

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

  /// ✅ Copy with method added here
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
      versionList:
          versionList != null
              ? versionList.map((v) => v.copyWith()).toList()
              : this.versionList.map((v) => v.copyWith()).toList(),
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

// class VideoModel {
//   final String name;
//   final String url;
//   final Duration duration;
//   final String? thumbnailPath;
//   int intervalSeconds;
//   int restTime;
//   List<VideoModel> versionList;

//   VideoModel({
//     required this.name,
//     required this.url,
//     required this.duration,
//     this.thumbnailPath,
//     this.intervalSeconds = 30,
//     this.restTime = 10,
//     required this.versionList ,
//   });

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is VideoModel &&
//           runtimeType == other.runtimeType &&
//           name == other.name &&
//           url == other.url &&
//           intervalSeconds == other.intervalSeconds;

//   @override
//   int get hashCode => name.hashCode ^ url.hashCode;
// }
