import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tl_customer/const/constant.dart';
import 'package:tl_customer/const/urls.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/bottomTab/component/bottom_tab.dart';
import 'package:tl_customer/screens/signin/model/signin_model.dart';
import 'package:tl_customer/screens/signup/component/authentication.dart';

class SigninController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool showMsg = false.obs;
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rstemailController = TextEditingController();
  TextEditingController rstNumberController = TextEditingController();
  Rx<SignInModel> signInModel = SignInModel().obs;

  login() async {
    if (numberController.text.isEmpty) {
      Fluttertoast.showToast(msg: "enter_phone_number".tr);
    } else if (numberController.text.trim().length < 9) {
      Fluttertoast.showToast(msg: "enter_phone_number_msg".tr);
      return;
    } else if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "enter_pin_msg".tr);
    } else if (passwordController.text.trim().length < 4) {
      Fluttertoast.showToast(msg: "enter_pin_msg1".tr);
    } else {
      signIn();
    }
  }

  Future signIn() async {
    try {
      isLoading(true);
      showMsg(false);
      var request = http.Request('POST', Uri.parse(Urls.signIn));
      request.body = json.encode({
        "username": numberController.text.trim(),
        "password": passwordController.text.trim(),
        "deviceId": Params.fcmToken
      });
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      var decodeData = jsonDecode(await response.stream.bytesToString());

      if (response.statusCode == 200) {
        signInModel.value = SignInModel.fromJson(decodeData);
        print("login response ==> $signInModel");

        SetSharedPref().setData(
            token: signInModel.value.token ?? "null",
            refreshToken: signInModel.value.refreshToken ?? "null",
            email: signInModel.value.username ?? "null",
            userid: signInModel.value.id ?? "null");
        Get.offAll(() => const BottomTab(), binding: InitialBinding());

        isLoading(false);
        showMsg(false);
      } else {
        showMsg(true);
        print("error ==> ${response.reasonPhrase}");
        isLoading(false);
      }
    } catch (e) {
      showMsg(true);
      isLoading(false);
      rethrow;
    }
  }

  Future resetPin() async {
    try {
      isLoading(true);
      var request = http.Request('POST', Uri.parse(Urls.generateOTPforget));
      request.body = json.encode({
        "userName": numberController.text.trim(),
        "phoneNumber": numberController.text.trim()
      });
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      // final result = jsonDecode(decodeData.body);
      print("result ==> ${decodeData.body}");

      if (response.statusCode == 200) {
        Get.to(
            () => Authentication(
                isReset: true, email: numberController.text.trim()),
            binding: InitialBinding());

        isLoading(false);
      } else {
        print("error ==> ${response.reasonPhrase}");
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }
}
