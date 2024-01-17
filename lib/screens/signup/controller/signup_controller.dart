import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tl_customer/const/constant.dart';

import 'package:tl_customer/const/urls.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/signin/component/signin.dart';
import 'package:tl_customer/screens/signup/component/authentication.dart';
import 'package:tl_customer/screens/signup/component/pin_setup.dart';
import 'package:http/http.dart' as http;
import 'package:tl_customer/screens/signup/component/change_profile.dart';
import 'package:tl_customer/screens/signup/model/signup_model.dart';
import 'package:tl_customer/widget/show_loader.dart';

class SignupController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isTermChecked = false.obs;
  RxBool pinMatch = false.obs;
  RxBool showTimer = false.obs;
  RxString gender = 'Female'.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lasttNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController pin1Controller = TextEditingController();
  TextEditingController pin2Controller = TextEditingController();
  RxInt secondsRemaining = 120.obs;
  Timer? timer;
  XFile path = XFile("null");
  Rx<SignupModel> signupModel = SignupModel().obs;

  @override
  void dispose() {
    secondsRemaining = 120.obs;
    showTimer(false);
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (secondsRemaining > 0) {
        secondsRemaining--;
      } else {
        secondsRemaining = 120.obs;
        showTimer(false);
        timer.cancel();
      }
    });
  }

  nextFuncation() {
    if (firstNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "enter_first_name_msg".tr);
    } else if (lasttNameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "enter_last_name_msg".tr);
    } else if (numberController.text.isEmpty) {
      Fluttertoast.showToast(msg: "enter_number_msg".tr);
    } else if (numberController.text.length < 9) {
      Fluttertoast.showToast(msg: "enter_valid_number_msg".tr);
    } else if (isTermChecked.value == false) {
      Fluttertoast.showToast(msg: "read_condition_msg".tr);
    } else {
      checkUser();
    }
  }

  Future verifyOTP(bool isReset) async {
    try {
      isLoading(true);

      var request = http.Request('POST', Uri.parse(Urls.validateOTP));
      request.body = json.encode({
        "otp": int.parse(otpController.text),
        "userName": numberController.text.trim(),
      });
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      // var decodeData = await http.Response.fromStream(response);
      // final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        signUp();
        isLoading(false);
      } else {
        showTimer(true);
        startTimer();
        Fluttertoast.showToast(msg: "valid_otp".tr);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  Future signUp() async {
    try {
      isLoading(true);

      var request = http.Request('POST', Uri.parse(Urls.signUp));
      request.body = json.encode({
        "phoneNumber": numberController.text.trim(),
        "firstName": firstNameController.text.trim(),
        "lastName": lasttNameController.text.trim(),
        "gender": gender.value,
        "deviceId": Params.fcmToken
      });
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        Get.to(() => PinSetup(isReset: false, token: ""),
            binding: InitialBinding());

        isLoading(false);
      } else {
        Fluttertoast.showToast(msg: result["message"]);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  Future setPin() async {
    try {
      isLoading(true);

      var request = http.Request('POST', Uri.parse(Urls.pinSetup));
      request.body = json.encode({
        "pin": pin2Controller.text.trim(),
        "username": numberController.text.trim(),
      });
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        print("pin setup ==> $result");
        signupModel.value = SignupModel.fromJson(result);
        Get.to(() => ChangeProfile(token: signupModel.value.token!),
            binding: InitialBinding());

        isLoading(false);
      } else {
        Fluttertoast.showToast(msg: result["message"]);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  Future uploadProfileImage(String token) async {
    try {
      isLoading(true);
      var request =
          http.MultipartRequest('POST', Uri.parse(Urls.uploadProfileImage));
      request.files.add(await http.MultipartFile.fromPath('image', path.path));
      request.headers.addAll({'Authorization': 'Bearer $token'});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("upload profile image response ==> $result");

      if (response.statusCode == 200) {
        isLoading(false);
        Fluttertoast.showToast(msg: result["message"]);
      } else {
        isLoading(false);
        Fluttertoast.showToast(msg: result["message"]);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  Future verifyFogetOTP(String email) async {
    try {
      var request = http.Request('POST', Uri.parse(Urls.validateOtpforget));
      request.body = json.encode({
        "otp": int.parse(otpController.text),
        "userName": email.trim(),
      });
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("result ==> ${result["token"]}");
      if (response.statusCode == 200) {
        Get.to(() => PinSetup(isReset: true, token: result["token"]),
            binding: InitialBinding());
      } else {
        Fluttertoast.showToast(msg: "valid_otp".tr);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future sendOTP() async {
    try {
      isLoading(true);

      var request = http.Request('POST', Uri.parse(Urls.sendOTP));
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
        Get.to(() => Authentication(isReset: false), binding: InitialBinding());
        Fluttertoast.showToast(
            msg: "${"otp_sent".tr} ${numberController.text.trim()}",
            toastLength: Toast.LENGTH_LONG);
        isLoading(false);
      } else {
        // Fluttertoast.showToast(msg: result["message"]);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  Future resendOTP(String number) async {
    try {
      const LoaderDialog().showLoader();
      var request = http.Request('POST', Uri.parse(Urls.sendOTP));
      request.body = json.encode({"userName": number, "phoneNumber": number});
      request.headers.addAll({'Content-Type': 'application/json'});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      // final result = jsonDecode(decodeData.body);
      print("resent otp result ==> ${decodeData.body}");

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "${"otp_sent".tr} $number", toastLength: Toast.LENGTH_LONG);
        const LoaderDialog().hideLoader();
      } else {
        Fluttertoast.showToast(msg: "otp_failed".tr);
        const LoaderDialog().hideLoader();
      }
    } catch (e) {
      const LoaderDialog().hideLoader();
      rethrow;
    }
  }

  Future resetPIN(bool isReset, String token) async {
    try {
      isLoading(true);
      var request = http.Request('PUT', Uri.parse(Urls.changePIN));
      request.body = json.encode({
        "newpin": pin2Controller.text.trim(),
      });
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("change pin ==> $result");
      if (response.statusCode == 200) {
        Get.offAll(() => SignIn(), binding: InitialBinding());
        isLoading(false);
      } else {
        isLoading(false);
        Fluttertoast.showToast(msg: "${result["message"]}".tr);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  Future checkUser() async {
    try {
      isLoading(true);
      var request = http.Request('GET',
          Uri.parse("${Urls.checkUser}/${numberController.text.trim()}"));

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("check user ==> ${result["exists"]}");

      if (result["exists"] == true) {
        Fluttertoast.showToast(msg: "already_use".tr);

        isLoading(false);
      } else {
        sendOTP();
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }
}
