class RegisterResponse {
  String? sId;
  String? phoneNumber;
  String? countryCode;
  String? fullName;
  String? village;
  String? createdAt;
  bool? isAdmin;
  int? creditCount;
  String? token;

  RegisterResponse(
      {this.sId, this.phoneNumber, this.countryCode, this.fullName, this.createdAt, this.isAdmin, this.creditCount, this.token, this.village});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phoneNumber = json['phoneNumber'];
    countryCode = json['countryCode'];
    fullName = json['fullName'];
    village = json['village'];
    createdAt = json['createdAt'];
    isAdmin = json['isAdmin'];
    creditCount = json['creditCount'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['phoneNumber'] = phoneNumber;
    data['countryCode'] = countryCode;
    data['fullName'] = fullName;
    data['village'] = village;
    data['createdAt'] = createdAt;
    data['isAdmin'] = isAdmin;
    data['creditCount'] = creditCount;
    data['token'] = token;
    return data;
  }
}
