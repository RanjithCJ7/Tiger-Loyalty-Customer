class ProfileModel {
  String? id;
  String? userName;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? gender;
  dynamic businessName;
  dynamic tin;
  dynamic category;
  dynamic location;
  dynamic rewardNumber;
  dynamic merchantDetailsId;
  dynamic subscriptionPlan;
  dynamic subscriptionStatus;
  dynamic startDate;
  dynamic endDate;
  dynamic lipaNumber;
  String? image;
  dynamic businessimage;
  dynamic whatsapp;
  dynamic facebook;
  dynamic instagram;
  dynamic twitter;
  dynamic paymentStatus;
  dynamic nextDueDate;
  dynamic lastPaymentDate;
  dynamic rewardTable;

  ProfileModel(
      {this.id,
      this.userName,
      this.phoneNumber,
      this.firstName,
      this.lastName,
      this.gender,
      this.businessName,
      this.tin,
      this.category,
      this.location,
      this.rewardNumber,
      this.merchantDetailsId,
      this.subscriptionPlan,
      this.subscriptionStatus,
      this.startDate,
      this.endDate,
      this.lipaNumber,
      this.image,
      this.businessimage,
      this.whatsapp,
      this.facebook,
      this.instagram,
      this.twitter,
      this.paymentStatus,
      this.nextDueDate,
      this.lastPaymentDate,
      this.rewardTable});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    businessName = json['businessName'];
    tin = json['tin'];
    category = json['category'];
    location = json['location'];
    rewardNumber = json['rewardNumber'];
    merchantDetailsId = json['merchantDetailsId'];
    subscriptionPlan = json['subscriptionPlan'];
    subscriptionStatus = json['subscriptionStatus'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    lipaNumber = json['lipaNumber'];
    image = json['image'];
    businessimage = json['businessimage'];
    whatsapp = json['whatsapp'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    paymentStatus = json['paymentStatus'];
    nextDueDate = json['nextDueDate'];
    lastPaymentDate = json['lastPaymentDate'];
    rewardTable = json['rewardTable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['userName'] = userName;
    data['phoneNumber'] = phoneNumber;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['businessName'] = businessName;
    data['tin'] = tin;
    data['category'] = category;
    data['location'] = location;
    data['rewardNumber'] = rewardNumber;
    data['merchantDetailsId'] = merchantDetailsId;
    data['subscriptionPlan'] = subscriptionPlan;
    data['subscriptionStatus'] = subscriptionStatus;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['lipaNumber'] = lipaNumber;
    data['image'] = image;
    data['businessimage'] = businessimage;
    data['whatsapp'] = whatsapp;
    data['facebook'] = facebook;
    data['instagram'] = instagram;
    data['twitter'] = twitter;
    data['paymentStatus'] = paymentStatus;
    data['nextDueDate'] = nextDueDate;
    data['lastPaymentDate'] = lastPaymentDate;
    data['rewardTable'] = rewardTable;
    return data;
  }
}
