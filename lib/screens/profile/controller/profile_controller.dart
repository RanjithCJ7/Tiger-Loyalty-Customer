import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tl_customer/const/constant.dart';
import 'package:tl_customer/const/urls.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/profile/model/profile_model.dart';
import 'package:tl_customer/screens/signin/component/signin.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  XFile path = XFile("null");
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  late http.Response profileImageURL;
  ValueNotifier<bool> notifieImage = ValueNotifier(true);
  TextEditingController newNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();

  @override
  void onInit() {
    userProfile();
    super.onInit();
  }

  Future uploadProfileImage() async {
    try {
      isLoading(true);
      var request =
          http.MultipartRequest('POST', Uri.parse(Urls.uploadProfileImage));
      request.files.add(await http.MultipartFile.fromPath('image', path.path));
      request.headers.addAll({'Authorization': 'Bearer ${Params.userToken}'});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("upload profile image response ==> $result");

      if (response.statusCode == 200) {
        userProfile();
        isLoading(false);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  Future userProfile() async {
    profileModel = ProfileModel().obs;
    try {
      isLoading(true);

      var request = http.Request('GET', Uri.parse(Urls.userProfile));

      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        profileModel.value = ProfileModel.fromJson(result);
        fetchProfileImage();
        update();
        isLoading(false);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  Future fetchProfileImage() async {
    try {
      isLoading(true);

      profileImageURL = await http.get(
        Uri.parse("${Urls.fetchProfileImage}/${profileModel.value.image}"),
        headers: {
          'Authorization': 'Bearer ${Params.userToken}',
        },
      );
      notifieImage.notifyListeners();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  Future sendOTP(String number) async {
    try {
      var request = http.Request('POST', Uri.parse(Urls.sendOTP));
      request.body = json.encode({"userName": number, "phoneNumber": number});
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      // final result = jsonDecode(decodeData.body);
      print("result ==> ${decodeData.body}");

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future verifyOTP(bool isChangeNumber, String number) async {
    try {
      var request = http.Request('POST', Uri.parse(Urls.validateOTP));
      request.body = json.encode({
        "otp": int.parse(otpController.text),
        "userName": number.trim(),
      });
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      // var decodeData = await http.Response.fromStream(response);
      // final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        if (isChangeNumber == true) {
          changeNumber();
        } else {
          changePIN();
        }
      } else {
        Fluttertoast.showToast(msg: "valid_otp".tr);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future changeNumber() async {
    try {
      var request = http.Request('POST', Uri.parse(Urls.changeNumber));
      request.body = json.encode({
        "phoneNumber": newNumberController.text.trim(),
      });
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("change number ==> $result");
      if (response.statusCode == 200) {
        userProfile();
      } else {
        Fluttertoast.showToast(msg: "${result["message"]}".tr);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future changePIN() async {
    try {
      var request = http.Request('PUT', Uri.parse(Urls.changePIN));
      request.body = json.encode({
        "newpin": pin2Controller.text.trim(),
      });
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("change pin ==> $result");
      if (response.statusCode == 200) {
        Get.close(1);
        userProfile();
      } else {
        Fluttertoast.showToast(msg: "${result["message"]}".tr);
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
