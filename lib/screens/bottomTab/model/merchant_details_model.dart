class MerchantDetailsModel {
  String? merchantId;
  String? image;
  String? lipaNumber;
  String? rewardNumber;
  String? merchantName;

  MerchantDetailsModel(
      {this.merchantId,
      this.image,
      this.lipaNumber,
      this.rewardNumber,
      this.merchantName});

  MerchantDetailsModel.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    image = json['image'];
    lipaNumber = json['lipaNumber'];
    rewardNumber = json['rewardNumber'];
    merchantName = json['merchantName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantId'] = this.merchantId;
    data['image'] = this.image;
    data['lipaNumber'] = this.lipaNumber;
    data['rewardNumber'] = this.rewardNumber;
    data['merchantName'] = this.merchantName;
    return data;
  }
}
