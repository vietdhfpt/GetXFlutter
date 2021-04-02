import 'dart:convert';

TopupBalance topupBalanceFromJson(String str) =>
    TopupBalance.fromJson(json.decode(str));
String topupBalanceToJson(TopupBalance data) => json.encode(data.toJson());

class TopupBalance {
  TopupBalance({
    this.error,
    this.message,
    this.data,
  });

  bool error;
  String message;
  Data data;

  factory TopupBalance.fromJson(Map<String, dynamic> json) => TopupBalance(
        error: json["error"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.balance,
  });

  int balance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
      };
}
