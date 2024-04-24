class LoginResponse {
  String? sId;
  String? phoneNumber;
  String? countryCode;
  String? fullName;
  String? createdAt;
  bool? isAdmin;
  int? creditCount;
  String? token;

  LoginResponse({this.sId, this.phoneNumber, this.countryCode, this.fullName, this.createdAt, this.isAdmin, this.creditCount, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phoneNumber = json['phoneNumber'];
    countryCode = json['countryCode'];
    fullName = json['fullName'];
    createdAt = json['createdAt'];
    isAdmin = json['isAdmin'];
    creditCount = json['creditCount'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phoneNumber'] = this.phoneNumber;
    data['countryCode'] = this.countryCode;
    data['fullName'] = this.fullName;
    data['createdAt'] = this.createdAt;
    data['isAdmin'] = this.isAdmin;
    data['creditCount'] = this.creditCount;
    data['token'] = this.token;
    return data;
  }
}
