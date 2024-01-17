import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tl_customer/const/constant.dart';
import 'package:tl_customer/const/urls.dart';
import 'package:tl_customer/screens/newUser/model/newuser_rewards_model.dart';

class RewardsNewUserController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  Rx<NewUserRewardsModel> allRewardPoints = NewUserRewardsModel().obs;
  Rx<NewUserRewardsModel> rewardPoints = NewUserRewardsModel().obs;
  RxList<String> businessCategories = [
    'business_category',
    "bakery",
    "bar",
    "beauty",
    "bookstore",
    "butcheries",
    "coffee_shops",
    "cosmetics",
    "decor",
    "electronics",
    "fashion",
    "fast_food",
    "florists",
    "groceries",
    "gym",
    "hotel",
    "laundry",
    "liquor_stores",
    "pets",
    "pharmacies",
    "resort",
    "restaurant",
    "saloon",
    "shopping",
    "spa",
    "supermarkets",
    "travel",
    "yoga",
  ].obs;
  RxString selectedCategory = 'business_category'.obs;

  @override
  void onInit() {
    getRewardsPoints();
    super.onInit();
  }

  Future getRewardsPoints() async {
    try {
      isLoading(true);
      var request =
          http.Request('GET', Uri.parse(Urls.getRewardDataForNonRegister));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.tempToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      if (response.statusCode == 200) {
        allRewardPoints.value = NewUserRewardsModel.fromJson(result);
        rewardPoints.value = NewUserRewardsModel.fromJson(result);
        print("response ==> ${allRewardPoints.value.responseList}");

        isLoading(false);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  filterList(String category) {
    rewardPoints.value.responseList = <ResponseList>[].obs;

    if (category.isEmpty) {
      rewardPoints.value.responseList = allRewardPoints.value.responseList;
    } else {
      for (var element in allRewardPoints.value.responseList!) {
        if (element.category!.toLowerCase() == category.toLowerCase()) {
          rewardPoints.value.responseList!.add(element);
        }
      }
    }
  }

  searchData() {
    rewardPoints.value.responseList = <ResponseList>[].obs;

    if (searchController.text.isEmpty) {
      rewardPoints.value.responseList = allRewardPoints.value.responseList;
    } else {
      for (var element in allRewardPoints.value.responseList!) {
        if (element.merchantName!
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          rewardPoints.value.responseList!.add(element);
        }
      }
    }
  }

  Future redeemPoints(String id, double points) async {
    try {
      isLoading(true);
      var request = http.Request('POST', Uri.parse(Urls.redeemPoints));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });
      request.body = json.encode({"merchantId": id, "points": points});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("redeemPoints response ==> $result");

      if (response.statusCode == 200) {
        // getRewardSummary(selectedCategory.value == "business_category"
        //     ? ""
        //     : "?category=${selectedCategory.value.tr}");
        getRewardsPoints().then((value) => filterList(
            selectedCategory.value == "business_category"
                ? ""
                : selectedCategory.value.tr));
        isLoading(false);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  Future sharePoints(String id) async {
    try {
      var request = http.Request('POST', Uri.parse(Urls.sharePoints));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });
      request.body = json.encode({
        "merchantId": id,
        "points": pointsController.text.trim(),
        "phoneNumber": numberController.text.trim()
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("sharePoints response ==> $result");

      if (response.statusCode == 200) {
        // getRewardSummary(selectedCategory.value == "business_category"
        //     ? ""
        //     : "?category=${selectedCategory.value.tr}");
        getRewardsPoints().then((value) => filterList(
            selectedCategory.value == "business_category"
                ? ""
                : selectedCategory.value.tr));
        Fluttertoast.showToast(msg: result["message"]);
      } else {
        Fluttertoast.showToast(msg: result["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
