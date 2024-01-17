class AllMerchantDetailsModel {
  String? merchantId;
  String? image;
  String? lipaNumber;
  String? rewardNumber;
  String? merchantName;
  UserInformation? userInformation;
  String? menu;
  double? averageRating;
  int? numberOfReviews;
  List<Reviews>? reviews;
  String? description;
  List<Locations>? locations;
  double? percentage;
  double? rewardPoints;

  AllMerchantDetailsModel(
      {this.merchantId,
      this.image,
      this.lipaNumber,
      this.rewardNumber,
      this.merchantName,
      this.userInformation,
      this.menu,
      this.averageRating,
      this.numberOfReviews,
      this.reviews,
      this.description,
      this.locations,
      this.percentage,
      this.rewardPoints});

  AllMerchantDetailsModel.fromJson(Map<String, dynamic> json) {
    merchantId = json['merchantId'];
    image = json['image'];
    lipaNumber = json['lipaNumber'];
    rewardNumber = json['rewardNumber'];
    merchantName = json['merchantName'];
    userInformation = json['userInformation'] != null
        ? UserInformation.fromJson(json['userInformation'])
        : null;
    menu = json['menu'];
    averageRating = json['averageRating'];
    numberOfReviews = json['numberOfReviews'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    description = json['description'];
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
    percentage = json['percentage'];
    rewardPoints = json['rewardPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['merchantId'] = merchantId;
    data['image'] = image;
    data['lipaNumber'] = lipaNumber;
    data['rewardNumber'] = rewardNumber;
    data['merchantName'] = merchantName;
    if (userInformation != null) {
      data['userInformation'] = userInformation!.toJson();
    }
    data['menu'] = menu;
    data['averageRating'] = averageRating;
    data['numberOfReviews'] = numberOfReviews;
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['description'] = description;
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    data['percentage'] = this.percentage;
    data['rewardPoints'] = this.rewardPoints;
    return data;
  }
}

class UserInformation {
  String? id;
  String? userName;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? gender;
  String? businessName;
  String? tin;
  String? category;
  String? location;
  String? rewardNumber;
  String? merchantDetailsId;
  String? subscriptionPlan;
  String? subscriptionStatus;
  String? startDate;
  String? endDate;
  String? lipaNumber;
  String? image;
  String? businessimage;
  dynamic whatsapp;
  dynamic facebook;
  dynamic instagram;
  dynamic twitter;
  String? paymentStatus;
  String? nextDueDate;
  String? lastPaymentDate;
  List<RewardTable>? rewardTable;

  UserInformation(
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

  UserInformation.fromJson(Map<String, dynamic> json) {
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
    if (json['rewardTable'] != null) {
      rewardTable = <RewardTable>[];
      json['rewardTable'].forEach((v) {
        rewardTable!.add(RewardTable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    if (rewardTable != null) {
      data['rewardTable'] = rewardTable!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RewardTable {
  String? id;
  double? min;
  double? max;
  double? reward;

  RewardTable({this.id, this.min, this.max, this.reward});

  RewardTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    min = json['min'];
    max = json['max'];
    reward = json['reward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['min'] = min;
    data['max'] = max;
    data['reward'] = reward;
    return data;
  }
}

class Reviews {
  String? id;
  String? merchantId;
  String? userId;
  int? rating;
  String? comment;
  String? createdDt;
  String? updatedDt;

  Reviews(
      {this.id,
      this.merchantId,
      this.userId,
      this.rating,
      this.comment,
      this.createdDt,
      this.updatedDt});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchantId'];
    userId = json['userId'];
    rating = json['rating'];
    comment = json['comment'];
    createdDt = json['createdDt'];
    updatedDt = json['updatedDt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['merchantId'] = merchantId;
    data['userId'] = userId;
    data['rating'] = rating;
    data['comment'] = comment;
    data['createdDt'] = createdDt;
    data['updatedDt'] = updatedDt;
    return data;
  }
}

class Locations {
  String? id;
  String? merchantId;
  String? location;
  String? createdDt;
  String? updatedDt;

  Locations(
      {this.id,
      this.merchantId,
      this.location,
      this.createdDt,
      this.updatedDt});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchantId'];
    location = json['location'];
    createdDt = json['createdDt'];
    updatedDt = json['updatedDt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['merchantId'] = merchantId;
    data['location'] = location;
    data['createdDt'] = createdDt;
    data['updatedDt'] = updatedDt;
    return data;
  }
}
