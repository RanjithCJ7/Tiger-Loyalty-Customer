import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tl_customer/const/constant.dart';
import 'package:tl_customer/const/urls.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/rewards/model/reward_points_model.dart';
import 'package:tl_customer/screens/rewards/model/reward_summary_model.dart';
import 'package:tl_customer/screens/rewards/model/transation_model.dart';
import 'package:tl_customer/screens/signin/component/signin.dart';

class RewardsController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController pointsController = TextEditingController();
  Rx<RewardSummaryModel> rewardSummary = RewardSummaryModel().obs;
  RxList<TransactionModel> allRewardPoints = <TransactionModel>[].obs;
  RxList<TransactionModel> rewardPoints = <TransactionModel>[].obs;
  // RxList<RewardsPointModel> allRewardPoints = <RewardsPointModel>[].obs;
  // RxList<RewardsPointModel> rewardPoints = <RewardsPointModel>[].obs;
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
    getRewardSummary("");
    super.onInit();
  }

  Future getRewardsPoints() async {
    try {
      isLoading(true);
      var request = http.Request('GET', Uri.parse(Urls.transactions));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        allRewardPoints.value = (result as List)
            .map((data) => TransactionModel.fromJson(data))
            .toList();
        rewardPoints.value = (result as List)
            .map((data) => TransactionModel.fromJson(data))
            .toList();

        isLoading(false);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }
  /* Future getRewardsPoints() async {
    try {
      isLoading(true);
      var request = http.Request('GET', Uri.parse(Urls.getRewardDataByBrand));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        allRewardPoints.value = (result as List)
            .map((data) => RewardsPointModel.fromJson(data))
            .toList();
        rewardPoints.value = (result as List)
            .map((data) => RewardsPointModel.fromJson(data))
            .toList();

        isLoading(false);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  } */

  Future getRewardSummary(String url) async {
    try {
      isLoading(true);
      var request = http.Request('GET', Uri.parse(Urls.getRewardSummary + url));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        rewardSummary.value = RewardSummaryModel.fromJson(result);
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
    rewardPoints = <TransactionModel>[].obs;

    if (category.isEmpty) {
      rewardPoints.value = allRewardPoints;
    } else {
      for (var element in allRewardPoints) {
        if (element.category!.toLowerCase() == category.toLowerCase()) {
          rewardPoints.add(element);
        }
      }
    }
  }

  searchData() {
    rewardPoints = <TransactionModel>[].obs;

    if (searchController.text.isEmpty) {
      rewardPoints.value = allRewardPoints;
    } else {
      for (var element in allRewardPoints) {
        if (element.merchantName!
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          rewardPoints.add(element);
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
        getRewardSummary(selectedCategory.value == "business_category"
            ? ""
            : "?category=${selectedCategory.value.tr}");
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
        getRewardSummary(selectedCategory.value == "business_category"
            ? ""
            : "?category=${selectedCategory.value.tr}");
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

  Future deleteAccount() async {
    try {
      var request = http.Request('DELETE', Uri.parse(Urls.deleteAccount));

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("delete Account ==> $result");
      if (response.statusCode == 200) {
        Get.close(1);
        Get.offAll(() => SignIn(), binding: InitialBinding());
        SetSharedPref().clearData();
      } else {
        Fluttertoast.showToast(msg: "${result["message"]}".tr);
      }
    } catch (e) {
      rethrow;
    }
  }
}
