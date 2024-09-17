// To parse this JSON data, do
//
//     final getTopUserDataResponseModel = getTopUserDataResponseModelFromJson(jsonString);

import 'dart:convert';

GetTopUserDataResponseModel getTopUserDataResponseModelFromJson(String str) => GetTopUserDataResponseModel.fromJson(json.decode(str));

String getTopUserDataResponseModelToJson(GetTopUserDataResponseModel data) => json.encode(data.toJson());

class GetTopUserDataResponseModel {
  int status;
  String message;
  List<Top50User> data;

  GetTopUserDataResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetTopUserDataResponseModel.fromJson(Map<String, dynamic> json) => GetTopUserDataResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<Top50User>.from(json["data"].map((x) => Top50User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Top50User {
  String id;
  String phoneNumber;
  String countryCode;
  String fullName;
  bool isAdmin;
  int creditCount;
  DateTime createdAt;
  int v;
  String? village;

  Top50User({
    required this.id,
    required this.phoneNumber,
    required this.countryCode,
    required this.fullName,
    required this.isAdmin,
    required this.creditCount,
    required this.createdAt,
    required this.v,
    this.village,
  });

  factory Top50User.fromJson(Map<String, dynamic> json) => Top50User(
    id: json["_id"],
    phoneNumber: json["phoneNumber"],
    countryCode: json["countryCode"],
    fullName: json["fullName"],
    isAdmin: json["isAdmin"],
    creditCount: json["creditCount"],
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
    village: json["village"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "phoneNumber": phoneNumber,
    "countryCode": countryCode,
    "fullName": fullName,
    "isAdmin": isAdmin,
    "creditCount": creditCount,
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
    "village": village,
  };
}
