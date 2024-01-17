// ignore_for_file: unnecessary_this

class RewardSummaryModel {
  int? count;
  double? totalPoints;

  RewardSummaryModel({this.count, this.totalPoints});

  RewardSummaryModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    totalPoints = json['totalPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = this.count;
    data['totalPoints'] = totalPoints;
    return data;
  }
}
