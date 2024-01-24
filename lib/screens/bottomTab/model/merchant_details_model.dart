class MerchantDetailsModel {
  String? merchantId;
  String? image;
  String? lipaNumber;
  String? rewardNumber;
  String? merchantName;
  double? percentage;
  double? rewardPoints;
  double? availablePoints;

  MerchantDetailsModel({
    this.merchantId,
    this.image,
    this.lipaNumber,
    this.rewardNumber,
    this.merchantName,
    this.percentage,
    this.rewardPoints,
    this.availablePoints,
  });

  MerchantDetailsModel.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    image = json['image'];
    lipaNumber = json['lipaNumber'];
    rewardNumber = json['rewardNumber'];
    merchantName = json['merchantName'];
    percentage = json['percentage'];
    rewardPoints = json['rewardPoints'];
    availablePoints = json['availablePoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantId'] = merchantId;
    data['image'] = image;
    data['lipaNumber'] = lipaNumber;
    data['rewardNumber'] = rewardNumber;
    data['merchantName'] = merchantName;
    data['percentage'] = percentage;
    data['rewardPoints'] = rewardPoints;
    data['availablePoints'] = availablePoints;
    return data;
  }
}
