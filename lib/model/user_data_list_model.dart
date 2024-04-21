import 'package:get/get.dart';

class UserDataListModel {
  String? sId;
  String? fullName;
  String? countryCode;
  String? phoneNumber;
  int? creditCount;
  String? createdAt;
  List<CreditList>? creditList;
  RxBool isExpand = false.obs;

  UserDataListModel({this.sId, this.fullName, this.countryCode, this.phoneNumber, this.creditCount, this.createdAt, this.creditList});

  UserDataListModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    creditCount = json['creditCount'];
    createdAt = json['createdAt'];
    if (json['creditList'] != null) {
      creditList = <CreditList>[];
      json['creditList'].forEach((v) {
        creditList!.add(CreditList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['creditCount'] = creditCount;
    data['createdAt'] = createdAt;
    if (creditList != null) {
      data['creditList'] = creditList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreditList {
  String? date;
  int? count;

  CreditList({this.date, this.count});

  CreditList.fromJson(Map<String, dynamic> json) {
    date = json['Date'];
    count = json['Count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Date'] = date;
    data['Count'] = count;
    return data;
  }
}
