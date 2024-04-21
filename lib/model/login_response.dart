class LoginResponse {
  bool? isNew;
  Doc? dDoc;
  String? token;

  LoginResponse({this.isNew, this.dDoc, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    isNew = json['$isNew'];
    dDoc = json['_doc'] != null ? Doc.fromJson(json['_doc']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$isNew'] = isNew;
    if (dDoc != null) {
      data['_doc'] = dDoc!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Doc {
  String? sId;
  String? phoneNumber;
  String? countryCode;
  String? fullName;
  bool? isAdmin;
  int? creditCount;
  String? createdAt;
  int? iV;

  Doc({this.sId, this.phoneNumber, this.countryCode, this.fullName, this.isAdmin, this.creditCount, this.createdAt, this.iV});

  Doc.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phoneNumber = json['phoneNumber'];
    countryCode = json['countryCode'];
    fullName = json['fullName'];
    isAdmin = json['isAdmin'];
    creditCount = json['creditCount'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['phoneNumber'] = phoneNumber;
    data['countryCode'] = countryCode;
    data['fullName'] = fullName;
    data['isAdmin'] = isAdmin;
    data['creditCount'] = creditCount;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
