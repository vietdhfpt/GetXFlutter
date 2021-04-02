import 'dart:convert';

TopupBase topupBaseFromJson(String str) => TopupBase.fromJson(json.decode(str));
String topupRegisterToJson(TopupBase data) => json.encode(data.toJson());

class TopupBase<T> {
  TopupBase({
    this.error,
    this.message,
    this.data,
  });

  bool error;
  String message;
  T data;

  factory TopupBase.fromJson(Map<String, dynamic> json) => TopupBase(
        error: json["error"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data,
      };
}
