class NewUserRewardsModel {
  List<ResponseList>? responseList;
  int? count;
  double? totalPoints;

  NewUserRewardsModel({this.responseList, this.count, this.totalPoints});

  NewUserRewardsModel.fromJson(Map<String, dynamic> json) {
    if (json['responseList'] != null) {
      responseList = <ResponseList>[];
      json['responseList'].forEach((v) {
        responseList!.add(new ResponseList.fromJson(v));
      });
    }
    count = json['count'];
    totalPoints = json['totalPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (responseList != null) {
      data['responseList'] = responseList!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    data['totalPoints'] = totalPoints;
    return data;
  }
}

class ResponseList {
  double? points;
  String? merchantName;
  String? merchantId;
  String? image;
  String? category;

  ResponseList(
      {this.points,
      this.merchantName,
      this.merchantId,
      this.image,
      this.category});

  ResponseList.fromJson(Map<String, dynamic> json) {
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
