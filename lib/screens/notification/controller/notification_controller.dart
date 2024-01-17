import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tl_customer/const/constant.dart';
import 'package:tl_customer/const/urls.dart';
import 'package:tl_customer/screens/notification/model/notification_model.dart';

ValueNotifier<String> notificationCount = ValueNotifier("0");

class NotificationController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;

  @override
  void onInit() {
    if (Params.userToken != "null") {
      fetchNotification();
    }
    super.onInit();
  }

  fetchNotification() async {
    try {
      isLoading(true);

      var request = http.Request('GET', Uri.parse(Urls.notification));

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        notificationList.value = (result as List)
            .map((data) => NotificationModel.fromJson(data))
            .toList();
        notificationList.sort((a, b) => b.createdDt!.compareTo(a.createdDt!));
        notificationCount.value = notificationList.length.toString();
        notificationCount.notifyListeners();

        isLoading(false);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  readAllNotification() async {
    try {
      isLoading(true);

      var request = http.Request('PUT', Uri.parse(Urls.readNotification));

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        fetchNotification();

        isLoading(false);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }
}
