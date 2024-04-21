class GlobalResponse {
  int? status;
  String? message;
  dynamic data;

  GlobalResponse({this.status, this.message, this.data});

  GlobalResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
