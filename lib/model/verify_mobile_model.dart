class VerifyMobileModel {
  bool? exists;

  VerifyMobileModel({this.exists});

  VerifyMobileModel.fromJson(Map<String, dynamic> json) {
    exists = json['exists'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exists'] = exists;
    return data;
  }
}
