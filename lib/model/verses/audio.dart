import 'dart:convert';

import 'package:flutter/foundation.dart';

class Audio {
  String url;
  int duration;
  Map<String, dynamic> segments;
  String format;
  Audio({
    this.url,
    this.duration,
    this.segments,
    this.format,
  });

  Audio copyWith({
    String url,
    int duration,
    Map<String, dynamic> segments,
    String format,
  }) {
    return Audio(
      url: url ?? this.url,
      duration: duration ?? this.duration,
      segments: segments ?? this.segments,
      format: format ?? this.format,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'duration': duration,
      'segments': segments,
      'format': format,
    };
  }

  factory Audio.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Audio(
      url: map['url'],
      duration: map['duration'],
      segments: Map<String, dynamic>.from(map['segments']),
      format: map['format'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Audio.fromJson(String source) => Audio.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Audio(url: $url, duration: $duration, segments: $segments, format: $format)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Audio &&
        o.url == url &&
        o.duration == duration &&
        mapEquals(o.segments, segments) &&
        o.format == format;
  }

  @override
  int get hashCode {
    return url.hashCode ^
        duration.hashCode ^
        segments.hashCode ^
        format.hashCode;
  }
}
