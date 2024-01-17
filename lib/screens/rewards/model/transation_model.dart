class TransactionModel {
  double? points;
  String? merchantName;
  String? merchantId;
  String? image;
  String? category;

  TransactionModel(
      {this.points,
      this.merchantName,
      this.merchantId,
      this.image,
      this.category});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    merchantName = json['merchantName'];
    merchantId = json['merchantId'];
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = points;
    data['merchantName'] = merchantName;
    data['merchantId'] = merchantId;
    data['image'] = image;
    data['category'] = category;
    return data;
  }
}
