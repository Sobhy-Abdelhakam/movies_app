// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'platform.dart';

class Source {
  String source;
    String link;
    String type;
    String? displayName;
    String? info;
    Platform? platform;
  Source({
    required this.source,
    required this.link,
    required this.type,
    this.displayName,
    this.info,
    this.platform,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        source: json["source"],
        link: json["link"],
        type: json["type"],
        displayName: json["display_name"],
        info: json["info"],
        platform: json["platform"] == null ? null : Platform.fromJson(json["platform"]),
    );
}
