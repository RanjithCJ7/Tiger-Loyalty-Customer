import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:external_path/external_path.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/const/constant.dart';
import 'package:tl_customer/const/urls.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/bottomTab/component/bottom_tab.dart';
import 'package:tl_customer/screens/bottomTab/model/make_payment_model.dart';
import 'package:tl_customer/screens/bottomTab/model/merchant_details_model.dart';
import 'package:tl_customer/screens/newUser/component/bottomtab_newuser.dart';

import 'package:tl_customer/screens/promo/model/merchant_details_model.dart';
import 'package:tl_customer/src/pages/styles.dart';
import 'package:http/http.dart' as http;
import 'package:tl_customer/widget/loader_widget.dart';
import 'package:tl_customer/widget/show_loader.dart';
import 'package:pdf/widgets.dart' as pw;

class NewuserController extends GetxController {
  TextEditingController lipaNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController saveNumberController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  Rx<MerchantDetailsModel> merchantDetails = MerchantDetailsModel().obs;
  Rx<AllMerchantDetailsModel> allMerchantDetails =
      AllMerchantDetailsModel().obs;
  Rx<MakePaymentModel> makePaymentModel = MakePaymentModel().obs;
  RxBool isLoadingMerchant = false.obs;
  RxDouble rating = 0.0.obs;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  final ScreenshotController screenshotController = ScreenshotController();

  Future<bool> makePayment(
      String merchantID, String amount, String number) async {
    isLoadingMerchant(true);
    var request = http.Request('POST', Uri.parse(Urls.makePaymentNonReg));
    request.headers.addAll({
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ${Params.userToken}'
    });
    request.body = json.encode({
      "merchantId": merchantID,
      "amount": amount,
      "phoneNumber": lipaNumberController.text.trim()
    });

    http.StreamedResponse response = await request.send();
    var decodeData = await http.Response.fromStream(response);
    final result = jsonDecode(decodeData.body);
    print("makePayment ==> ${result}");
    if (response.statusCode == 200) {
      makePaymentModel.value = MakePaymentModel.fromJson(result);

      isLoadingMerchant(false);
      return true;
    } else {
      Fluttertoast.showToast(msg: result["message"]);
      isLoadingMerchant(false);
      return false;
    }
  }

  Future<bool> getMerchantByNumber() async {
    try {
      isLoadingMerchant(true);
      var request = http.Request(
          'GET',
          Uri.parse(
              "${Urls.getMerchantDetailNonReg}?lipaNumber=${lipaNumberController.text.trim()}"));
      request.headers.addAll({
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        merchantDetails.value = MerchantDetailsModel.fromJson(result);
        isLoadingMerchant(false);
        return true;
      } else {
        isLoadingMerchant(false);
        Fluttertoast.showToast(msg: "lipa_valid".tr);
        return false;
      }
    } catch (e) {
      isLoadingMerchant(false);
      return false;
    }
  }

  Future<bool> getMerchantByReward() async {
    try {
      isLoadingMerchant(true);
      var request = http.Request(
          'GET',
          Uri.parse(
              "${Urls.getMerchantDetailNonReg}?rewardNumber=${lipaNumberController.text.trim()}"));
      request.headers.addAll({
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        merchantDetails.value = MerchantDetailsModel.fromJson(result);
        isLoadingMerchant(false);
        return true;
      } else {
        isLoadingMerchant(false);
        Fluttertoast.showToast(msg: "lipa_valid".tr);
        return false;
      }
    } catch (e) {
      isLoadingMerchant(false);

      return false;
    }
  }

  Future<bool> getMerchantByNumberPoints() async {
    try {
      isLoadingMerchant(true);
      var request = http.Request(
          'GET',
          Uri.parse(
              "${Urls.getMerchantDetailNonReg}?lipaNumber=${lipaNumberController.text.trim()}&amount=${amountController.text.trim()}"));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        allMerchantDetails.value = AllMerchantDetailsModel.fromJson(result);
        isLoadingMerchant(false);
        return true;
      } else {
        isLoadingMerchant(false);
        Fluttertoast.showToast(msg: "lipa_valid".tr);
        return false;
      }
    } catch (e) {
      isLoadingMerchant(false);
      return false;
    }
  }

  Future<bool> getMerchantByRewardPoints() async {
    isLoadingMerchant(true);
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              "${Urls.getMerchantDetailNonReg}?rewardNumber=${lipaNumberController.text.trim()}&amount=${amountController.text.trim()}"));
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        allMerchantDetails.value = AllMerchantDetailsModel.fromJson(result);
        isLoadingMerchant(false);
        return true;
      } else {
        isLoadingMerchant(false);
        Fluttertoast.showToast(msg: "lipa_valid".tr);
        return false;
      }
    } catch (e) {
      isLoadingMerchant(false);

      return false;
    }
  }

  Future<bool> postReview() async {
    try {
      isLoadingMerchant(true);
      var request = http.Request(
          'POST',
          Uri.parse(
              "${Urls.postReview}/${merchantDetails.value.merchantId}/reviews"));
      request.headers.addAll({
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${Params.userToken}'
      });
      request.body = json.encode(
          {"rating": rating.value, "comment": reviewController.text.trim()});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("review response ==> $result");
      if (response.statusCode == 200) {
        isLoadingMerchant(false);

        return true;
      } else {
        isLoadingMerchant(false);
        Fluttertoast.showToast(msg: result["message"]);
        return false;
      }
    } catch (e) {
      isLoadingMerchant(false);

      return false;
    }
  }

  Future redeemPoints(String id) async {
    try {
      var request = http.Request('POST', Uri.parse(Urls.redeemPoints));
      request.headers.addAll({
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${Params.userToken}'
      });
      request.body = json
          .encode({"merchantId": id, "points": amountController.text.trim()});

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);
      print("redeemPoints response ==> $result");

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future saveReward() async {
    try {
      isLoadingMerchant(true);
      var request = http.Request('POST', Uri.parse(Urls.saveRewards));
      request.headers.addAll({
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${Params.userToken}'
      });
      request.body = json.encode({
        "merchantId": merchantDetails.value.merchantId,
        "amount": amountController.text.trim(),
        "phoneNumber": saveNumberController.text.trim()
      });

      http.StreamedResponse response = await request.send();
      var decodeData = await http.Response.fromStream(response);
      final result = jsonDecode(decodeData.body);

      if (response.statusCode == 200) {
        print("save rewards ==> ${result["token"]}");
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("tempToken", result["token"]);
        pref.setString("tokenExpiry", DateTime.now().toString());
        Params.tempToken = result["token"];
        Params.tokenExpiry = DateTime.now().toString();
        Get.offAll(() => const BottomTabNewUser(), binding: InitialBinding());
        isLoadingMerchant(false);
      } else {
        isLoadingMerchant(false);
        Fluttertoast.showToast(msg: "transaction_failed".tr);
      }
    } catch (e) {
      isLoadingMerchant(false);
      rethrow;
    }
  }

  openCamera() async {
    try {
      var status = await Permission.camera.status;
      if (status.isPermanentlyDenied) {
        openAppSettings();
      } else if (!status.isGranted) {
        status = await Permission.camera.request();
        if (status.isGranted) {
          scanQRBottomSheet();
        } else {
          Fluttertoast.showToast(msg: "camera_required".tr);
          openAppSettings();
        }
      } else {
        scanQRBottomSheet();
      }
    } catch (e) {
      rethrow;
    }
  }

  scanQRBottomSheet() {
    lipaNumberController.clear();
    amountController.clear();
    numberController.clear();

    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'scan_to'.tr,
                          style: alertTitle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    width: Get.width * 0.7,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFF5F5F5)),
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: 'amount'.tr,
                              hintStyle:
                                  const TextStyle(color: Color(0xFF808080)),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(20),
                            ),
                            style: textFieldStyle,
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Stack(
                        //   children: [
                        //     Image.asset('assets/qr_code.png'),
                        //     Image.asset('assets/bg_qr_code.png'),
                        //   ],
                        // ),
                        SizedBox(
                          width: Get.width,
                          height: Get.height * 0.3,
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                          ),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(top: 25.0, bottom: 20.0),
                          child: Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: Color(0xFF808080),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text("or".tr, style: orText),
                              ),
                              const Expanded(
                                child: Divider(
                                  color: Color(0xFF808080),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFF5F5F5)),
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextField(
                            controller: lipaNumberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                            decoration: InputDecoration(
                              hintText: 'enter_lipa_number'.tr,
                              hintStyle:
                                  const TextStyle(color: Color(0xFF808080)),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(20),
                            ),
                            style: textFieldStyle,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: Get.width * 0.8,
                          height: Get.width * 0.12,
                          child: TextButton(
                            onPressed: () {
                              if (lipaNumberController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "lipa_required_msg".tr);
                              } else if (amountController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "enter_amount_msg".tr);
                              } /* else if (bottomTabController
                                      .lipaNumberController.text.length <
                                  6) {
                                Fluttertoast.showToast(msg: "lipa_valid".tr);
                              } */
                              else {
                                if (lipaNumberController.text.length > 6) {
                                  getMerchantByNumber().then((value) {
                                    if (value) {
                                      Get.close(1);
                                      paymentBottomSheet();
                                    }
                                  });
                                } else {
                                  getMerchantByReward().then((value) {
                                    if (value) {
                                      Get.close(1);
                                      paymentBottomSheet();
                                    }
                                  });
                                }
                              }
                            },
                            style: btnGold2,
                            child: Text(
                              'next'.tr,
                              style: btnGoldText2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.03)
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    Get.close(1);
                  },
                  child: Image.asset('assets/close.png'),
                ),
              ),
            ],
          ),
        ));
  }

  paymentBottomSheet() {
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        Obx(
          () => isLoadingMerchant.value
              ? const LoaderWidget()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.close(1);
                            },
                            child: Image.asset('assets/close.png'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.15,
                      height: Get.height * 0.075,
                      child: Stack(
                        children: [
                          Align(
                            child: Container(
                              width: Get.width * 0.14,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFD9D9D9),
                                  width: 2,
                                ),
                              ),
                              child: merchantDetails.value.image == null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage:
                                          AssetImage(Images.profile),
                                      radius: Get.width * 0.14,
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: NetworkImage(
                                          merchantDetails.value.image!),
                                      radius: Get.width * 0.14,
                                    ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Image.asset('assets/lc_check.png'))
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(merchantDetails.value.merchantName ?? "",
                        style: pointsDesc),
                    const SizedBox(height: 20),
                    Text('transaction_value'.tr, style: dialogTextSm),
                    const SizedBox(height: 15),
                    Text(
                        NumberFormat("#,##0")
                            .format(int.parse(amountController.text)),
                        style: filterText),
                    const SizedBox(height: 30),
                    Text('what_to_do'.tr, style: label_sm),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: Get.width * 0.8,
                      height: Get.width * 0.12,
                      child: TextButton(
                        style: btnGrey,
                        onPressed: () {
                          /* if (lipaNumberController.text.length > 6) {
                            getMerchantByNumberPoints().then((value) {
                              if (value) {
                                Get.close(1);
                                redeemBottomSheet();
                              }
                            });
                          } else {
                            getMerchantByRewardPoints().then((value) {
                              if (value) {
                                Get.close(1);
                                redeemBottomSheet();
                              }
                            });
                          } */
                        },
                        child: Text(
                          'redeem_earnedpoints'.tr,
                          style: btnGreyText.copyWith(
                              color: const Color(0xFFACACAC)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: Get.width * 0.8,
                      height: Get.width * 0.12,
                      child: TextButton(
                        style: btnGrey,
                        onPressed: () {
                          Get.close(1);
                          saveRewardBottomSheet();
                          // submitReviewBottomSheet(false);
                        },
                        child: Text(
                          'pay_cash'.tr,
                          style: btnGreyText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: Get.width * 0.8,
                      height: Get.width * 0.12,
                      child: TextButton(
                        style: btnGrey,
                        onPressed: () {
                          Get.close(1);
                          payToCollectBottomSheet();
                        },
                        child: Text(
                          'pay_to_collect'.tr,
                          style: btnGreyText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
        ));
  }

  payToCollectBottomSheet() {
    numberController.clear();
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('make_payment_to'.tr, style: settingsTitle),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: Get.width * 0.15,
                    height: Get.height * 0.075,
                    child: Stack(
                      children: [
                        Align(
                          child: Container(
                            width: Get.width * 0.14,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFD9D9D9),
                                width: 2,
                              ),
                            ),
                            child: merchantDetails.value.image == null
                                ? CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(Images.profile),
                                    radius: Get.width * 0.14,
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(
                                        merchantDetails.value.image!),
                                    radius: Get.width * 0.14,
                                  ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Image.asset('assets/lc_check.png'))
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(merchantDetails.value.merchantName ?? "",
                      style: pointsDesc),
                  const SizedBox(height: 10),
                  Text(
                      NumberFormat("#,##0")
                          .format(int.parse(amountController.text)),
                      style: filterText),
                  const SizedBox(height: 10),
                  Text('amount_to_pay'.tr, style: dialogTextSm),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: Get.width * 0.5,
                    child: Text('enter_number_to_pay'.tr,
                        style: label_sm, textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: Get.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFF5F5F5)),
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset('assets/ion_keypad.png'),
                        ),
                        Expanded(
                          child: TextField(
                            controller: numberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                            decoration: InputDecoration(
                              hintText: 'phone_number'.tr,
                              hintStyle:
                                  const TextStyle(color: Color(0xFF808080)),
                              border: InputBorder.none,
                            ),
                            style: textFieldStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text('popup_to_pay'.tr, style: desc),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.width * 0.8,
                    height: Get.width * 0.12,
                    child: TextButton(
                      onPressed: () {
                        if (numberController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "enter_number_msg".tr);
                        } else if (numberController.text.length < 9) {
                          Fluttertoast.showToast(
                              msg: "enter_valid_number_msg".tr);
                        } else {
                          makePayment(merchantDetails.value.merchantId!,
                                  amountController.text, numberController.text)
                              .then((value) {
                            if (value == true) {
                              Get.close(1);
                              payBottomSheet();
                            } else {
                              Get.close(1);
                              Get.to(() => const FailedTransaction())!
                                  .then((value) => paymentBottomSheet());
                            }
                          });
                        }
                      },
                      style: btnGold2,
                      child: Text(
                        'pay'.tr,
                        style: btnGoldText2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30)
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    Get.close(1);
                  },
                  child: Image.asset('assets/close.png'),
                ),
              ),
            ],
          ),
        ));
  }

  payBottomSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      Obx(
        () => isLoadingMerchant.value
            ? const LoaderWidget()
            : Screenshot(
                controller: screenshotController,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('payment_success'.tr,
                                    style: settingsTitle),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 30),
                              SizedBox(
                                width: Get.width * 0.15,
                                height: Get.height * 0.075,
                                child: Stack(
                                  children: [
                                    Align(
                                      child: Container(
                                        width: Get.width * 0.14,
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFFD9D9D9),
                                            width: 2,
                                          ),
                                        ),
                                        child: merchantDetails.value.image ==
                                                null
                                            ? CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage:
                                                    AssetImage(Images.profile),
                                                radius: Get.width * 0.14,
                                              )
                                            : CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: NetworkImage(
                                                    merchantDetails
                                                        .value.image!),
                                                radius: Get.width * 0.14,
                                              ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child:
                                            Image.asset('assets/lc_check.png'))
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(merchantDetails.value.merchantName ?? "",
                                  style: pointsDesc),
                              const SizedBox(height: 30),
                              Text(
                                  "${double.parse(makePaymentModel.value.rewardPoints.toString())}",
                                  style: filterText),
                              const SizedBox(height: 5),
                              Text('bonus_points'.tr, style: dialogTextSm),
                              const SizedBox(height: 20),
                              Center(
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            NumberFormat("#,##0").format(
                                                int.parse(
                                                    amountController.text)),
                                            style: numGreyText),
                                        Text('transaction_value'.tr,
                                            style: dialogTextSm),
                                      ],
                                    ),
                                    const SizedBox(width: 15),
                                    Image.asset('assets/line_col.png'),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${makePaymentModel.value.percentage.toString()}%",
                                            style: numGreyText),
                                        Text('reward'.tr, style: dialogTextSm)
                                      ],
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              SizedBox(
                                width: Get.width * 0.9,
                                height: Get.height * 0.07,
                                child: TextButton(
                                  onPressed: () {
                                    Get.close(1);
                                    saveRewardBottomSheet();
                                    // submitReviewBottomSheet();
                                  },
                                  style: btnGrey,
                                  child:
                                      Text('save_reward'.tr, style: label_sm2),
                                ),
                              ),
                              const SizedBox(height: 50),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: InkWell(
                          onTap: () {
                            Get.close(1);
                          },
                          child: Image.asset('assets/close.png'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  saveRewardBottomSheet() {
    saveNumberController.clear();
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('savereward'.tr, style: alertTitle),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: Get.width * 0.48,
                    child: Text(
                      'savereward_desc'.tr,
                      style: desc,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    width: Get.width * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFF5F5F5)),
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Image.asset('assets/ion_keypad.png'),
                        ),
                        Expanded(
                          child: TextField(
                            controller: saveNumberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10)
                            ],
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'phone_number'.tr,
                              hintStyle:
                                  const TextStyle(color: Color(0xFF808080)),
                              border: InputBorder.none,
                            ),
                            style: textFieldStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Get.width * 0.8,
                    height: Get.width * 0.12,
                    child: TextButton(
                      onPressed: () {
                        if (saveNumberController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "enter_number_msg".tr);
                        } else if (saveNumberController.text.trim().length <
                            9) {
                          Fluttertoast.showToast(
                              msg: "enter_valid_number_msg".tr);
                        } else {
                          Get.close(1);
                          saveReward();
                        }
                      },
                      style: btnGold2,
                      child: Text(
                        'savereward'.tr,
                        style: btnGoldText2,
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.1)
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child: InkWell(
                  onTap: () {
                    Get.close(1);
                  },
                  child: Image.asset('assets/close.png'),
                ),
              )
            ],
          ),
        ));
  }

  _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      print("scan==> ${scanData.code ?? ""}");
      if (scanData.code!.length < 4) {
        Fluttertoast.showToast(msg: "lipa_valid".tr);
      } else if (!isNumeric(scanData.code!)) {
        Fluttertoast.showToast(msg: "lipa_valid".tr);
      } else {
        lipaNumberController.text = scanData.code!;
        controller.pauseCamera();
      }
    });
  }

  bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void resumeCamera() {
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  submitReviewBottomSheet(bool show) {
    rating.value = 0.0;
    reviewController.clear();
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12))), SingleChildScrollView(
      child: StatefulBuilder(builder: (context, setState) {
        return Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('review'.tr, style: filterText),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                SizedBox(
                  width: Get.width * 0.2,
                  height: Get.height * 0.1,
                  child: Stack(
                    children: [
                      Align(
                        child: Container(
                          width: Get.width * 0.2,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFD9D9D9),
                              width: 2,
                            ),
                          ),
                          child: merchantDetails.value.image == null
                              ? CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(Images.profile),
                                  radius: Get.width * 0.16,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: NetworkImage(
                                      merchantDetails.value.image!),
                                  radius: Get.width * 0.16,
                                ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 10,
                          child: Image.asset('assets/lc_check.png'))
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Text(merchantDetails.value.merchantName ?? "",
                    style: pointsDesc),
                const SizedBox(height: 30),
                Container(
                  width: Get.width * 0.8,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: Color(0XFFD9D9D9),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('rate_experience'.tr, style: desc),
                    const SizedBox(height: 15),
                    SmoothStarRating(
                      onRatingChanged: (value) {
                        setState(() {
                          rating.value = value;
                        });
                      },
                      allowHalfRating: true,
                      starCount: 5,
                      rating: rating.value,
                      size: 30.0,
                      color: Colors.black,
                      borderColor: Colors.black,
                      spacing: 0.0,
                    ),
                    const SizedBox(height: 40),
                    Text('comment'.tr, style: desc),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: Get.width * 0.8,
                      child: TextField(
                        controller: reviewController,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFD9D9D9),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: Get.width * 0.8,
                      height: Get.height * 0.07,
                      child: TextButton(
                        onPressed: () {
                          if (reviewController.text.isEmpty) {
                            Fluttertoast.showToast(msg: "review_desc".tr);
                          } else {
                            postReview().then(
                                (value) => show ? Get.close(2) : Get.close(1));
                          }
                        },
                        style: btnGrey,
                        child: Text('post'.tr, style: label_sm2),
                      ),
                    ),
                    const SizedBox(height: 40),
                    if (show) ...[
                      Center(
                        child: TextButton(
                          onPressed: () {
                            shareFile();
                          },
                          child: Column(
                            children: [
                              Image.asset('assets/share.png'),
                              const SizedBox(height: 10),
                              Text('share_receipt'.tr)
                            ],
                          ),
                        ),
                      )
                    ]
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  show ? Get.close(2) : Get.close(1);
                },
                child: Image.asset('assets/close.png'),
              ),
            ),
          ],
        );
      }),
    ));
  }

  shareFile() async {
    try {
      const LoaderDialog().showLoader();
      Uint8List? capturedImage = await screenshotController.capture();

      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Image(pw.MemoryImage(capturedImage!));
          },
        ),
      );

      final output = await getExternalStorageDirectory();
      final file = File(
          '${output!.path}/${merchantDetails.value.merchantName ?? "Tiger Loyalty"}_${generateRandomString(1)}.pdf');
      final pdfBytes = await pdf.save();
      await file.writeAsBytes(pdfBytes);

      var path = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      String filePath =
          "$path/${merchantDetails.value.merchantName ?? "Tiger Loyalty"}_${generateRandomString(1)}.pdf";

      File fileDef = File(filePath);
      XFile fileDef1 = XFile(filePath);
      await fileDef.create(recursive: true);
      Uint8List bytes = await file.readAsBytes();
      await fileDef.writeAsBytes(bytes);
      Share.shareXFiles([fileDef1]);

      const LoaderDialog().hideLoader();
    } catch (e) {
      const LoaderDialog().hideLoader();
      rethrow;
    }
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = '1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  pinBottomSheet() {
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.close(1);
                    },
                    child: Image.asset('assets/close.png'),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Image.asset('assets/authentication.png'),
                const SizedBox(height: 15),
                Text('enter_pin'.tr, style: charityLabel),
                const SizedBox(height: 30.0),
                Text(
                    '${"to_redeem".tr} ${NumberFormat("#,##0").format(int.parse(amountController.text))} ${"points_at".tr} ${merchantDetails.value.merchantName ?? ""}',
                    style: desc),
                const SizedBox(height: 50),
                Row(
                  children: [
                    const SizedBox(width: 25),
                    Container(
                      width: Get.width * 0.6,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFF5F5F5)),
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            child: Image.asset('assets/pin.png'),
                          ),
                          Expanded(
                            child: TextField(
                              controller: pinController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4)
                              ],
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'pin'.tr,
                                hintStyle:
                                    const TextStyle(color: Color(0xFF808080)),
                                border: InputBorder.none,
                              ),
                              style: textFieldStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        if (pinController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "enter_pin_msg".tr);
                        } else if (pinController.text.length < 4) {
                          Fluttertoast.showToast(msg: "enter_pin_msg1".tr);
                        } else {
                          Get.close(1);
                        }
                      },
                      style: btnGold2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 8.0),
                        child: Row(
                          children: [
                            Text(
                              'submit'.tr,
                              style: btnGoldText,
                            ),
                            const SizedBox(width: 10),
                            Image.asset('assets/btn_arrow_right.png'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.05),
          ],
        ));
  }

  redeemBottomSheet() {
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        Obx(
          () => isLoadingMerchant.value
              ? const LoaderWidget()
              : Screenshot(
                  controller: screenshotController,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('redeem_points'.tr,
                                      style: settingsTitle),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(height: Get.height * 0.04),
                                SizedBox(
                                  width: Get.width * 0.15,
                                  height: Get.height * 0.075,
                                  child: Stack(
                                    children: [
                                      Align(
                                        child: Container(
                                          width: Get.width * 0.14,
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: const Color(0xFFD9D9D9),
                                              width: 2,
                                            ),
                                          ),
                                          child: merchantDetails.value.image ==
                                                  null
                                              ? CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage: AssetImage(
                                                      Images.profile),
                                                  radius: Get.width * 0.14,
                                                )
                                              : CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage: NetworkImage(
                                                      merchantDetails
                                                          .value.image!),
                                                  radius: Get.width * 0.14,
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Image.asset(
                                              'assets/lc_check.png'))
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Text(merchantDetails.value.merchantName ?? "",
                                    style: pointsDesc),
                                const SizedBox(height: 30),
                                Text(
                                    NumberFormat("#,##0").format(int.parse(
                                        double.parse(allMerchantDetails
                                                .value.rewardPoints
                                                .toString())
                                            .round()
                                            .toString())),
                                    style: filterText),
                                const SizedBox(height: 5),
                                Text('bonus_points'.tr, style: dialogTextSm),
                                const SizedBox(height: 20),
                                Center(
                                  child: Row(
                                    children: [
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              NumberFormat("#,##0").format(
                                                  int.parse(
                                                      amountController.text)),
                                              style: numGreyText),
                                          Text('transaction_value'.tr,
                                              style: dialogTextSm),
                                        ],
                                      ),
                                      const SizedBox(width: 15),
                                      Image.asset('assets/line_col.png'),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${allMerchantDetails.value.percentage.toString()}%",
                                              style: numGreyText),
                                          Text('reward'.tr, style: dialogTextSm)
                                        ],
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 50),
                                SizedBox(
                                  width: Get.width * 0.8,
                                  height: Get.width * 0.12,
                                  child: TextButton(
                                    style: btnGold,
                                    onPressed: () {
                                      Get.close(1);
                                      submitReviewBottomSheet(false);
                                    },
                                    child: Text(
                                      'redeem_pay'.tr,
                                      style: const TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                              ],
                            )
                          ],
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              Get.close(1);
                            },
                            child: Image.asset('assets/close.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ));
  }
}
