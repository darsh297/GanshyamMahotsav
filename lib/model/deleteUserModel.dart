// To parse this JSON data, do
//
//     final deleteUserModel = deleteUserModelFromJson(jsonString);

import 'dart:convert';

DeleteUserModel deleteUserModelFromJson(String str) => DeleteUserModel.fromJson(json.decode(str));

String deleteUserModelToJson(DeleteUserModel data) => json.encode(data.toJson());

class DeleteUserModel {
  int status;
  String message;
  Data data;

  DeleteUserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteUserModel.fromJson(Map<String, dynamic> json) => DeleteUserModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  bool acknowledged;
  int deletedCount;

  Data({
    required this.acknowledged,
    required this.deletedCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    acknowledged: json["acknowledged"],
    deletedCount: json["deletedCount"],
  );

  Map<String, dynamic> toJson() => {
    "acknowledged": acknowledged,
    "deletedCount": deletedCount,
  };
}
