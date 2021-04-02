import 'dart:convert';

TopupRegister topupRegisterFromJson(String str) =>
    TopupRegister.fromJson(json.decode(str));
String topupRegisterToJson(TopupRegister data) => json.encode(data.toJson());

class TopupRegister {
  TopupRegister({
    this.error,
    this.message,
    this.data,
  });

  bool error;
  String message;
  String data;

  factory TopupRegister.fromJson(Map<String, dynamic> json) => TopupRegister(
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
