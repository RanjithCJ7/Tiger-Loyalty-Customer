class MakePaymentModel {
  String? merchantId;
  dynamic merchantName;
  double? percentage;
  double? rewardPoints;
  String? amount;
  bool? status;

  MakePaymentModel(
      {this.merchantId,
      this.merchantName,
      this.percentage,
      this.rewardPoints,
      this.amount,
      this.status});

  MakePaymentModel.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    merchantName = json['merchantName'];
    percentage = json['percentage'];
    rewardPoints = json['rewardPoints'];
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['merchantId'] = merchantId;
    data['merchantName'] = merchantName;
    data['percentage'] = percentage;
    data['rewardPoints'] = rewardPoints;
    data['amount'] = amount;
    data['status'] = status;
    return data;
  }
}
