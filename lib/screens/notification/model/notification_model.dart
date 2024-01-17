class NotificationModel {
  String? id;
  String? title;
  String? description;
  String? userId;
  bool? read;
  String? createdDt;
  String? updatedDt;

  NotificationModel(
      {this.id,
      this.title,
      this.description,
      this.userId,
      this.read,
      this.createdDt,
      this.updatedDt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    read = json['read'];
    createdDt = json['createdDt'];
    updatedDt = json['updatedDt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['userId'] = userId;
    data['read'] = read;
    data['createdDt'] = createdDt;
    data['updatedDt'] = updatedDt;
    return data;
  }
}
