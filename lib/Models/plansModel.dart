// To parse this JSON data, do
//
//     final viewPlansModel = viewPlansModelFromJson(jsonString);

import 'dart:convert';

ViewPlansModel viewPlansModelFromJson(String str) => ViewPlansModel.fromJson(json.decode(str));

String viewPlansModelToJson(ViewPlansModel data) => json.encode(data.toJson());

class ViewPlansModel {
  String? status;
  bool? success;
  String? message;
  List<PlanDetail>? data;
  int? page;

  ViewPlansModel({
    this.status,
    this.success,
    this.message,
    this.data,
    this.page,
  });

  factory ViewPlansModel.fromJson(Map<String, dynamic> json) => ViewPlansModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<PlanDetail>.from(json["data"]!.map((x) => PlanDetail.fromJson(x))),
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "page": page,
  };
}

class PlanDetail {
  String? id;
  String? advertisementTypeId;
  String? title;
  int? price;
  int? duretion;
  int? dailySpendBudget;
  int? aiImageCount;
  bool? disable;
  int? instaBudget;
  int? googleBudget;
  int? facebookBudget;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  dynamic views;
  dynamic reach;
  dynamic leads;

  PlanDetail({
    this.id,
    this.advertisementTypeId,
    this.title,
    this.price,
    this.duretion,
    this.dailySpendBudget,
    this.aiImageCount,
    this.disable,
    this.instaBudget,
    this.googleBudget,
    this.facebookBudget,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.views,
    this.reach,
    this.leads,
  });

  factory PlanDetail.fromJson(Map<String, dynamic> json) => PlanDetail(
    id: json["_id"],
    advertisementTypeId: json["advertisementTypeId"],
    title: json["title"],
    price: json["price"],
    duretion: json["duretion"],
    dailySpendBudget: json["dailySpendBudget"],
    aiImageCount: json["aiImageCount"],
    disable: json["disable"],
    instaBudget: json["instaBudget"],
    googleBudget: json["googleBudget"],
    facebookBudget: json["facebookBudget"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    views: json["views"],
    reach: json["reach"],
    leads: json["leads"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "advertisementTypeId": advertisementTypeId,
    "title": title,
    "price": price,
    "duretion": duretion,
    "dailySpendBudget": dailySpendBudget,
    "aiImageCount": aiImageCount,
    "disable": disable,
    "instaBudget": instaBudget,
    "googleBudget": googleBudget,
    "facebookBudget": facebookBudget,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "views": views,
    "reach": reach,
    "leads": leads,
  };
}


enum AdvertisementTypeId {
  THE_615_F4_B3_B7_B3_B3_B001_F3_B3_B3_B,
  THE_6656_CEDE1302350_B8_BE0_AF1_E
}

final advertisementTypeIdValues = EnumValues({
  "615f4b3b7b3b3b001f3b3b3b": AdvertisementTypeId.THE_615_F4_B3_B7_B3_B3_B001_F3_B3_B3_B,
  "6656cede1302350b8be0af1e": AdvertisementTypeId.THE_6656_CEDE1302350_B8_BE0_AF1_E
});

enum Title {
  GOOGLE,
  SK_E_SOLUTION
}

final titleValues = EnumValues({
  "Google": Title.GOOGLE,
  "SK e solution": Title.SK_E_SOLUTION
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}