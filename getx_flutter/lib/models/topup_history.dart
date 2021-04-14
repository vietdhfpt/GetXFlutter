import 'dart:convert';

TopupHistoryResp topupHistoryRespFromJson(String str) =>
    TopupHistoryResp.fromJson(json.decode(str));
String topupHistoryRespToJson(TopupHistoryResp data) =>
    json.encode(data.toJson());

class TopupHistoryResp {
  TopupHistoryResp({
    this.error,
    this.message,
    this.data,
  });

  bool error;
  Message message;
  List<Datum> data;

  factory TopupHistoryResp.fromJson(Map<String, dynamic> json) =>
      TopupHistoryResp(
        error: json["error"],
        message: messageValues.map[json["message"]],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": messageValues.reverse[message],
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.status,
    this.requestId,
    this.info,
    this.createdAt,
    this.requestParams,
    this.responseData,
  });

  Message status;
  String requestId;
  Info info;
  int createdAt;
  RequestParams requestParams;
  ResponseData responseData;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        status: messageValues.map[json["status"]],
        requestId: json["requestId"],
        info: Info.fromJson(json["info"]),
        createdAt: json["createdAt"],
        requestParams: RequestParams.fromJson(json["requestParams"]),
        responseData: json["responseData"] == null
            ? null
            : ResponseData.fromJson(json["responseData"]),
      );

  Map<String, dynamic> toJson() => {
        "status": messageValues.reverse[status],
        "requestId": requestId,
        "info": info.toJson(),
        "createdAt": createdAt,
        "requestParams": requestParams.toJson(),
        "responseData": responseData == null ? null : responseData.toJson(),
      };
}

class Info {
  Info({
    this.totalAmount,
    this.merchant,
    this.master,
    this.refundAmount,
    this.note,
  });

  int totalAmount;
  Master merchant;
  Master master;
  int refundAmount;
  String note;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
        merchant:
            json["merchant"] == null ? null : Master.fromJson(json["merchant"]),
        master: json["master"] == null ? null : Master.fromJson(json["master"]),
        refundAmount:
            json["refundAmount"] == null ? null : json["refundAmount"],
        note: json["note"] == null ? null : json["note"],
      );

  Map<String, dynamic> toJson() => {
        "totalAmount": totalAmount == null ? null : totalAmount,
        "merchant": merchant == null ? null : merchant.toJson(),
        "master": master == null ? null : master.toJson(),
        "refundAmount": refundAmount == null ? null : refundAmount,
        "note": note == null ? null : note,
      };
}

class Master {
  Master({
    this.profit,
    this.price,
  });

  int profit;
  int price;

  factory Master.fromJson(Map<String, dynamic> json) => Master(
        profit: json["profit"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "profit": profit,
        "price": price,
      };
}

class RequestParams {
  RequestParams({
    this.softpinKey,
    this.buyItems,
    this.keyBirthdayTime,
    this.requestId,
    this.token,
    this.username,
    this.forRequestId,
    this.providerCode,
    this.topupAmount,
    this.accountType,
    this.targetAccount,
    this.shopid,
    this.amount,
  });

  SoftpinKey softpinKey;
  List<BuyItem> buyItems;
  KeyBirthdayTime keyBirthdayTime;
  String requestId;
  Token token;
  Username username;
  String forRequestId;
  ProviderCode providerCode;
  int topupAmount;
  String accountType;
  String targetAccount;
  String shopid;
  int amount;

  factory RequestParams.fromJson(Map<String, dynamic> json) => RequestParams(
        softpinKey: json["softpinKey"] == null
            ? null
            : softpinKeyValues.map[json["softpinKey"]],
        buyItems: json["buyItems"] == null
            ? null
            : List<BuyItem>.from(
                json["buyItems"].map((x) => BuyItem.fromJson(x))),
        keyBirthdayTime: json["keyBirthdayTime"] == null
            ? null
            : keyBirthdayTimeValues.map[json["keyBirthdayTime"]],
        requestId: json["requestID"] == null ? null : json["requestID"],
        token: json["token"] == null ? null : tokenValues.map[json["token"]],
        username: json["username"] == null
            ? null
            : usernameValues.map[json["username"]],
        forRequestId:
            json["forRequestId"] == null ? null : json["forRequestId"],
        providerCode: json["providerCode"] == null
            ? null
            : providerCodeValues.map[json["providerCode"]],
        topupAmount: json["topupAmount"] == null ? null : json["topupAmount"],
        accountType: json["accountType"] == null ? null : json["accountType"],
        targetAccount:
            json["targetAccount"] == null ? null : json["targetAccount"],
        shopid: json["shopid"] == null ? null : json["shopid"],
        amount: json["amount"] == null ? null : json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "softpinKey":
            softpinKey == null ? null : softpinKeyValues.reverse[softpinKey],
        "buyItems": buyItems == null
            ? null
            : List<dynamic>.from(buyItems.map((x) => x.toJson())),
        "keyBirthdayTime": keyBirthdayTime == null
            ? null
            : keyBirthdayTimeValues.reverse[keyBirthdayTime],
        "requestID": requestId == null ? null : requestId,
        "token": token == null ? null : tokenValues.reverse[token],
        "username": username == null ? null : usernameValues.reverse[username],
        "forRequestId": forRequestId == null ? null : forRequestId,
        "providerCode": providerCode == null
            ? null
            : providerCodeValues.reverse[providerCode],
        "topupAmount": topupAmount == null ? null : topupAmount,
        "accountType": accountType == null ? null : accountType,
        "targetAccount": targetAccount == null ? null : targetAccount,
        "shopid": shopid == null ? null : shopid,
        "amount": amount == null ? null : amount,
      };
}

class BuyItem {
  BuyItem({
    this.productId,
    this.quantity,
  });

  int productId;
  int quantity;

  factory BuyItem.fromJson(Map<String, dynamic> json) => BuyItem(
        productId: json["productId"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
      };
}

enum KeyBirthdayTime { THE_20210402095921833, THE_20210113094112133 }

final keyBirthdayTimeValues = EnumValues({
  "2021/01/13 09:41:12.133": KeyBirthdayTime.THE_20210113094112133,
  "2021/04/02 09:59:21.833": KeyBirthdayTime.THE_20210402095921833
});

enum ProviderCode { VINAPHONE, MOBIFONE, VIETTEL }

final providerCodeValues = EnumValues({
  "Mobifone": ProviderCode.MOBIFONE,
  "Viettel": ProviderCode.VIETTEL,
  "Vinaphone": ProviderCode.VINAPHONE
});

enum SoftpinKey {
  THE_4_D3_F4_B3_AB53442_B3581_CA9_CF,
  CF514_BACB185657_ABC0_B2165
}

final softpinKeyValues = EnumValues({
  "cf514bacb185657abc0b2165": SoftpinKey.CF514_BACB185657_ABC0_B2165,
  "4d3f4b3ab53442b3581ca9cf": SoftpinKey.THE_4_D3_F4_B3_AB53442_B3581_CA9_CF
});

enum Token {
  ADBEB42_D3149_C16_F1878_D49_D51753_D4_BBBA5_A45_AE4_DBC9_CE,
  DEDFC2_CD9283747_EA6_C1_E6_EB396_C158_B3_BA67468_FEA7_EA4_F,
  D716_A14_B37_C583_B38_C267_FD27_FF8_A8_EA5_A59_F7_D3_E4_DBE666,
  THE_1_CEA4_B43339_F45_AA75_BBD244_A93_CC7_F92_CCE88_B35_E637776,
  THE_78_C4_AA841_C3366_B77_BA2_DA2_FA7_E33_FB8_A389_B26_F7_F25_AE8_B
}

final tokenValues = EnumValues({
  "adbeb42d3149c16f1878d49d51753d4bbba5a45ae4dbc9ce":
      Token.ADBEB42_D3149_C16_F1878_D49_D51753_D4_BBBA5_A45_AE4_DBC9_CE,
  "d716a14b37c583b38c267fd27ff8a8ea5a59f7d3e4dbe666":
      Token.D716_A14_B37_C583_B38_C267_FD27_FF8_A8_EA5_A59_F7_D3_E4_DBE666,
  "dedfc2cd9283747ea6c1e6eb396c158b3ba67468fea7ea4f":
      Token.DEDFC2_CD9283747_EA6_C1_E6_EB396_C158_B3_BA67468_FEA7_EA4_F,
  "1cea4b43339f45aa75bbd244a93cc7f92cce88b35e637776":
      Token.THE_1_CEA4_B43339_F45_AA75_BBD244_A93_CC7_F92_CCE88_B35_E637776,
  "78c4aa841c3366b77ba2da2fa7e33fb8a389b26f7f25ae8b":
      Token.THE_78_C4_AA841_C3366_B77_BA2_DA2_FA7_E33_FB8_A389_B26_F7_F25_AE8_B
});

enum Username { IMEDIA_DEV6, IMEDIA_DEV8 }

final usernameValues = EnumValues(
    {"IMEDIA_DEV6": Username.IMEDIA_DEV6, "IMEDIA_DEV8": Username.IMEDIA_DEV8});

class ResponseData {
  ResponseData({
    this.merchantBalance,
    this.signature,
    this.requestId,
    this.errorMessage,
    this.errorCode,
    this.sysTransId,
    this.token,
    this.products,
  });

  int merchantBalance;
  String signature;
  String requestId;
  ErrorMessage errorMessage;
  int errorCode;
  int sysTransId;
  Token token;
  List<Product> products;

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
        merchantBalance: json["merchantBalance"],
        signature: json["signature"],
        requestId: json["requestID"],
        errorMessage: errorMessageValues.map[json["errorMessage"]],
        errorCode: json["errorCode"],
        sysTransId: json["sysTransId"],
        token: json["token"] == null ? null : tokenValues.map[json["token"]],
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "merchantBalance": merchantBalance,
        "signature": signature,
        "requestID": requestId,
        "errorMessage": errorMessageValues.reverse[errorMessage],
        "errorCode": errorCode,
        "sysTransId": sysTransId,
        "token": token == null ? null : tokenValues.reverse[token],
        "products": products == null
            ? null
            : List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

enum ErrorMessage {
  SUCCESS,
  TOKEN_IS_NOT_EXISTED,
  FAIL_BECAUSE_PRODUCT_NOT_IN_PARTNER_TEMPLATE,
  TARGET_ACCOUNT_INVALID,
  FAIL_BECAUSE_SOFTPIN_IS_NOT_ENOUGH_FOR_REQUEST,
  TELCO_SYSTEM_BUSY,
  INVALID_SIGNATURE,
  FAIL_MERCHANT_AMOUNT_LEVEL
}

final errorMessageValues = EnumValues({
  "Merchant topup a target or amount level which are not in template":
      ErrorMessage.FAIL_MERCHANT_AMOUNT_LEVEL,
  "fail because product not in partner template":
      ErrorMessage.FAIL_BECAUSE_PRODUCT_NOT_IN_PARTNER_TEMPLATE,
  "Target account is too short or too long":
      ErrorMessage.TARGET_ACCOUNT_INVALID,
  "fail because softpin is not enough for request":
      ErrorMessage.FAIL_BECAUSE_SOFTPIN_IS_NOT_ENOUGH_FOR_REQUEST,
  "INVALID SIGNATURE": ErrorMessage.INVALID_SIGNATURE,
  "success": ErrorMessage.SUCCESS,
  "Telco system busy.": ErrorMessage.TELCO_SYSTEM_BUSY,
  "Token is not existed.": ErrorMessage.TOKEN_IS_NOT_EXISTED,
});

class Product {
  Product({
    this.softpins,
    this.commission,
    this.productValue,
    this.productId,
    this.categoryName,
    this.serviceProviderName,
  });

  List<Softpin> softpins;
  double commission;
  int productValue;
  int productId;
  dynamic categoryName;
  dynamic serviceProviderName;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        softpins: List<Softpin>.from(
            json["softpins"].map((x) => Softpin.fromJson(x))),
        commission: json["commission"].toDouble(),
        productValue: json["productValue"],
        productId: json["productId"],
        categoryName: json["categoryName"],
        serviceProviderName: json["serviceProviderName"],
      );

  Map<String, dynamic> toJson() => {
        "softpins": List<dynamic>.from(softpins.map((x) => x.toJson())),
        "commission": commission,
        "productValue": productValue,
        "productId": productId,
        "categoryName": categoryName,
        "serviceProviderName": serviceProviderName,
      };
}

class Softpin {
  Softpin({
    this.expiryDate,
    this.softpinPinCode,
    this.softpinSerial,
    this.softpinId,
  });

  ExpiryDate expiryDate;
  String softpinPinCode;
  String softpinSerial;
  int softpinId;

  factory Softpin.fromJson(Map<String, dynamic> json) => Softpin(
        expiryDate: expiryDateValues.map[json["expiryDate"]],
        softpinPinCode: json["softpinPinCode"],
        softpinSerial: json["softpinSerial"],
        softpinId: json["softpinId"],
      );

  Map<String, dynamic> toJson() => {
        "expiryDate": expiryDateValues.reverse[expiryDate],
        "softpinPinCode": softpinPinCode,
        "softpinSerial": softpinSerial,
        "softpinId": softpinId,
      };
}

enum ExpiryDate { THE_20230202000000, THE_20231205000000 }

final expiryDateValues = EnumValues({
  "2023/02/02 00:00:00": ExpiryDate.THE_20230202000000,
  "2023/12/05 00:00:00": ExpiryDate.THE_20231205000000
});

enum Message { SUCCESS, REFUNDED, FAILED }

final messageValues = EnumValues({
  "Failed": Message.FAILED,
  "Refunded": Message.REFUNDED,
  "Success": Message.SUCCESS
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
