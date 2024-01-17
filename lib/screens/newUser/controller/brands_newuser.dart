import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/const/constant.dart';
import 'package:tl_customer/const/urls.dart';
import 'package:tl_customer/screens/newUser/model/newuser_rewards_model.dart';
import 'package:tl_customer/screens/promo/model/merchant_details_model.dart';

class FilterModel {
  String image;
  String name;

  FilterModel({
    required this.image,
    required this.name,
  });
}

class BrandsNewUserController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingMerchant = false.obs;
  Rx<NewUserRewardsModel> allRewardPoints = NewUserRewardsModel().obs;
  Rx<NewUserRewardsModel> rewardPoints = NewUserRewardsModel().obs;
  TextEditingController searchController = TextEditingController();
  List<FilterModel> filterData = [
    FilterModel(image: Images.shopping, name: 'Shopping'),
    FilterModel(image: Images.supermarket, name: 'Supermarket'),
    FilterModel(image: Images.restaurant, name: 'Restaurant'),
    FilterModel(image: Images.spa, name: 'Spa'),
    FilterModel(image: Images.salon, name: 'Salon'),
  ];
  FilterModel selectedFilter =
      FilterModel(image: Images.allFilter, name: 'All');
  Rx<AllMerchantDetailsModel> merchantDeatails = AllMerchantDetailsModel().obs;
  Rx<Locations> selectedLocations = Locations().obs;

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

  Future getMerchantDetails(String id) async {
    try {
      isLoadingMerchant(true);
      var request = http.Request(
          'GET', Uri.parse("${Urls.getMerchantDetail}?merchantId=$id"));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        merchantDeatails.value = AllMerchantDetailsModel.fromJson(result);
        if (merchantDeatails.value.locations!.isNotEmpty) {
          selectedLocations.value = merchantDeatails.value.locations![0];
        } else {
          selectedLocations.value.location == null;
        }

        isLoadingMerchant(false);
      } else {
        isLoadingMerchant(false);
        Fluttertoast.showToast(msg: result["message"]);
      }
    } catch (e) {
      isLoadingMerchant(false);
      rethrow;
    }
  }
}
