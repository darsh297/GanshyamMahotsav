class PdfListingResponse {
  String? sId;
  String? fileName;
  String? description;
  String? image;
  String? language;
  String? createdAt;
  int? iV;

  PdfListingResponse({this.sId, this.fileName, this.description, this.image, this.language, this.createdAt, this.iV});

  PdfListingResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fileName = json['fileName'];
    description = json['description'];
    image = json['image'];
    language = json['language'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fileName'] = fileName;
    data['description'] = description;
    data['image'] = image;
    data['language'] = language;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}
