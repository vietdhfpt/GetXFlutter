import 'dart:convert';

TopupProduct topupProductsFromJson(String str) =>
    TopupProduct.fromJson(json.decode(str));
String topupProductsToJson(TopupProduct data) => json.encode(data.toJson());

class TopupProduct {
  TopupProduct({
    this.error,
    this.message,
    this.data,
  });

  bool error;
  String message;
  List<Datum> data;

  factory TopupProduct.fromJson(Map<String, dynamic> json) => TopupProduct(
        error: json["error"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.type,
    this.label,
    this.description,
    this.template,
    this.query,
    this.items,
  });

  String type;
  String label;
  String description;
  Template template;
  Query query;
  List<Item> items;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["type"],
        label: json["label"],
        description: json["description"],
        template: templateValues.map[json["template"]],
        query: Query.fromJson(json["query"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "label": label,
        "description": description,
        "template": templateValues.reverse[template],
        "query": query.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.id,
    this.name,
    this.description,
    this.category,
    this.subcategory,
    this.provider,
    this.providerName,
    this.productValue,
    this.commission,
    this.masterCommission,
    this.finalPrice,
    this.accountType,
  });

  int id;
  String name;
  Description description;
  Template category;
  Subcategory subcategory;
  String provider;
  ProviderName providerName;
  int productValue;
  double commission;
  int masterCommission;
  int finalPrice;
  String accountType;

  int payBack() {
    return productValue - finalPrice;
  }

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        description: Description.fromJson(json["description"]),
        category: templateValues.map[json["category"]],
        subcategory: subcategoryValues.map[json["subcategory"]],
        provider: json["provider"],
        providerName: providerNameValues.map[json["providerName"]],
        productValue: json["productValue"],
        commission: json["commission"].toDouble(),
        masterCommission: json["masterCommission"],
        finalPrice: json["finalPrice"],
        accountType: json["accountType"] == null ? null : json["accountType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description.toJson(),
        "category": templateValues.reverse[category],
        "subcategory": subcategoryValues.reverse[subcategory],
        "provider": provider,
        "providerName": providerNameValues.reverse[providerName],
        "productValue": productValue,
        "commission": commission,
        "masterCommission": masterCommission,
        "finalPrice": finalPrice,
        "accountType": accountType == null ? null : accountType,
      };
}

enum Template { ECARD, TOPUP }

final templateValues =
    EnumValues({"ecard": Template.ECARD, "topup": Template.TOPUP});

class Description {
  Description({
    this.data,
    this.package,
    this.expire,
  });

  String data;
  String package;
  Expire expire;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        data: json["data"] == null ? null : json["data"],
        package: json["package"] == null ? null : json["package"],
        expire:
            json["expire"] == null ? null : expireValues.map[json["expire"]],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? null : data,
        "package": package == null ? null : package,
        "expire": expire == null ? null : expireValues.reverse[expire],
      };
}

enum Expire { THE_30_D, THE_3_D, THE_15_D, THE_24_H, THE_10_D, THE_7_D }

final expireValues = EnumValues({
  "10d": Expire.THE_10_D,
  "15d": Expire.THE_15_D,
  "24h": Expire.THE_24_H,
  "30d": Expire.THE_30_D,
  "3d": Expire.THE_3_D,
  "7d": Expire.THE_7_D
});

enum ProviderName {
  VIETTEL,
  VINAPHONE,
  MOBIFONE,
  VTC,
  FPT,
  VINAGAME,
  BEELINE,
  VIETNAM_MOBILE,
  VDC_NET2_E,
  GARENA,
  Q_PAL,
  APPOTA,
  FUNCARD
}

final providerNameValues = EnumValues({
  "Appota": ProviderName.APPOTA,
  "Beeline": ProviderName.BEELINE,
  "FPT": ProviderName.FPT,
  "Funcard": ProviderName.FUNCARD,
  "Garena": ProviderName.GARENA,
  "Mobifone": ProviderName.MOBIFONE,
  "QPal": ProviderName.Q_PAL,
  "VDC-Net2E": ProviderName.VDC_NET2_E,
  "Vietnam Mobile": ProviderName.VIETNAM_MOBILE,
  "Viettel": ProviderName.VIETTEL,
  "Vinagame": ProviderName.VINAGAME,
  "Vinaphone": ProviderName.VINAPHONE,
  "VTC": ProviderName.VTC
});

enum Subcategory { MOBILE, GAME, DATA }

final subcategoryValues = EnumValues({
  "data": Subcategory.DATA,
  "game": Subcategory.GAME,
  "mobile": Subcategory.MOBILE
});

class Query {
  Query({
    this.category,
    this.subcategory,
    this.accountType,
  });

  Template category;
  List<Subcategory> subcategory;
  String accountType;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        category: templateValues.map[json["category"]],
        subcategory: List<Subcategory>.from(
            json["subcategory"].map((x) => subcategoryValues.map[x])),
        accountType: json["accountType"] == null ? null : json["accountType"],
      );

  Map<String, dynamic> toJson() => {
        "category": templateValues.reverse[category],
        "subcategory": List<dynamic>.from(
            subcategory.map((x) => subcategoryValues.reverse[x])),
        "accountType": accountType == null ? null : accountType,
      };
}

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
