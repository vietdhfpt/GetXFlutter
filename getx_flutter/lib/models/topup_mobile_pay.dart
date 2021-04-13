import 'dart:convert';

TopupMobilePay topupMobilePayFromJson(String str) =>
    TopupMobilePay.fromJson(json.decode(str));
String topupMobilePayToJson(TopupMobilePay data) => json.encode(data.toJson());

class TopupMobilePay {
  TopupMobilePay({
    this.error,
    this.message,
    this.data,
  });

  bool error;
  String message;
  Data data;

  factory TopupMobilePay.fromJson(Map<String, dynamic> json) => TopupMobilePay(
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
    this.errorCode,
    this.errorMessage,
    this.merchantBalance,
    this.products,
    this.requestId,
    this.sysTransId,
    this.masterBalance,
  });

  int errorCode;
  String errorMessage;
  int merchantBalance;
  dynamic products;
  String requestId;
  int sysTransId;
  int masterBalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        errorCode: json["errorCode"],
        errorMessage: json["errorMessage"],
        merchantBalance: json["merchantBalance"],
        products: json["products"],
        requestId: json["requestID"],
        sysTransId: json["sysTransId"],
        masterBalance: json["masterBalance"],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "errorMessage": errorMessage,
        "merchantBalance": merchantBalance,
        "products": products,
        "requestID": requestId,
        "sysTransId": sysTransId,
        "masterBalance": masterBalance,
      };
}
