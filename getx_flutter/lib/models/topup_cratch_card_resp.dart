import 'dart:convert';

TopupCratchCardResp topupCratchCardRespFromJson(String str) =>
    TopupCratchCardResp.fromJson(json.decode(str));
String topupCratchCardRespToJson(TopupCratchCardResp data) =>
    json.encode(data.toJson());

class TopupCratchCardResp {
  TopupCratchCardResp({
    this.error,
    this.message,
    this.data,
  });

  bool error;
  String message;
  Data data;

  factory TopupCratchCardResp.fromJson(Map<String, dynamic> json) =>
      TopupCratchCardResp(
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
  List<Product> products;
  String requestId;
  int sysTransId;
  int masterBalance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        errorCode: json["errorCode"],
        errorMessage: json["errorMessage"],
        merchantBalance: json["merchantBalance"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        requestId: json["requestID"],
        sysTransId: json["sysTransId"],
        masterBalance: json["masterBalance"],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "errorMessage": errorMessage,
        "merchantBalance": merchantBalance,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "requestID": requestId,
        "sysTransId": sysTransId,
        "masterBalance": masterBalance,
      };
}

class Product {
  Product({
    this.productId,
    this.productValue,
    this.categoryName,
    this.serviceProviderName,
    this.commission,
    this.softpins,
  });

  int productId;
  int productValue;
  dynamic categoryName;
  dynamic serviceProviderName;
  double commission;
  List<Softpin> softpins;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        productValue: json["productValue"],
        categoryName: json["categoryName"],
        serviceProviderName: json["serviceProviderName"],
        commission: json["commission"].toDouble(),
        softpins: List<Softpin>.from(
            json["softpins"].map((x) => Softpin.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "productValue": productValue,
        "categoryName": categoryName,
        "serviceProviderName": serviceProviderName,
        "commission": commission,
        "softpins": List<dynamic>.from(softpins.map((x) => x.toJson())),
      };
}

class Softpin {
  Softpin({
    this.softpinId,
    this.softpinSerial,
    this.softpinPinCode,
    this.expiryDate,
  });

  int softpinId;
  String softpinSerial;
  String softpinPinCode;
  String expiryDate;

  factory Softpin.fromJson(Map<String, dynamic> json) => Softpin(
        softpinId: json["softpinId"],
        softpinSerial: json["softpinSerial"],
        softpinPinCode: json["softpinPinCode"],
        expiryDate: json["expiryDate"],
      );

  Map<String, dynamic> toJson() => {
        "softpinId": softpinId,
        "softpinSerial": softpinSerial,
        "softpinPinCode": softpinPinCode,
        "expiryDate": expiryDate,
      };
}
