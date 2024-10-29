class Platform {
  String? android;
  String? androidTv;
  String? ios;
  String? web;
  Platform({
    this.android,
    this.androidTv,
    this.ios,
    this.web,
  });

  factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        android: json["android"],
        androidTv: json["android_tv"],
        ios: json["ios"],
        web: json["web"],
    );
}
