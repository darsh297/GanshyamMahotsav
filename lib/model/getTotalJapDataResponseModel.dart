// To parse this JSON data, do
//
//     final getTotalJapDataResponseModel = getTotalJapDataResponseModelFromJson(jsonString);

import 'dart:convert';

GetTotalJapDataResponseModel getTotalJapDataResponseModelFromJson(String str) => GetTotalJapDataResponseModel.fromJson(json.decode(str));

String getTotalJapDataResponseModelToJson(GetTotalJapDataResponseModel data) => json.encode(data.toJson());

class GetTotalJapDataResponseModel {
  int status;
  String message;
  Data data;

  GetTotalJapDataResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetTotalJapDataResponseModel.fromJson(Map<String, dynamic> json) => GetTotalJapDataResponseModel(
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
  int today;
  int week;
  int month;
  int total;
  int totalUser;
  int myRank;
  int totalMantrajap;

  Data({
    required this.today,
    required this.week,
    required this.month,
    required this.total,
    required this.totalUser,
    required this.myRank,
    required this.totalMantrajap,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    today: json["today"],
    week: json["week"],
    month: json["month"],
    total: json["total"],
    totalUser: json["totalUser"],
    myRank: json["myRank"],
    totalMantrajap: json["totalMantrajap"],
  );

  Map<String, dynamic> toJson() => {
    "today": today,
    "week": week,
    "month": month,
    "total": total,
    "totalUser": totalUser,
    "myRank": myRank,
    "totalMantrajap": totalMantrajap,
  };
}
