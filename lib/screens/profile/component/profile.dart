import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/const/constant.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/profile/component/choose_profile_photo.dart';
import 'package:tl_customer/screens/profile/component/view_profile.dart';
import 'package:tl_customer/screens/profile/controller/profile_controller.dart';
import 'package:tl_customer/screens/signin/component/signin.dart';
import 'package:tl_customer/widget/loader_widget.dart';
import 'package:tl_customer/widget/select_image.dart';
import 'package:tl_customer/widget/translate_language.dart';
import '../../../src/pages/styles.dart';
import 'package:http/http.dart' as http;

class SettingData {
  String text;
  String image;

  SettingData({required this.text, required this.image});
}

List<SettingData> settingData = [
  SettingData(text: 'change_pin', image: 'assets/setting_3.png'),
  SettingData(text: 'change_phone_num', image: 'assets/setting_4.png'),
  SettingData(text: 'terms_condition', image: 'assets/setting_5.png'),
  SettingData(text: 'privacy_policy', image: 'assets/setting_6.png'),
  SettingData(text: 'about_tl', image: 'assets/setting_7.png'),
];

class Profile extends StatelessWidget {
  ProfileController profileController = Get.find<ProfileController>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => profileController.isLoading.value
            ? const LoaderWidget()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: Get.height * 0.02),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Image.asset('assets/bg_rectangle.png')),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: Get.width * 0.25,
                                child: Stack(children: [
                                  Align(
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: const Color(0xFFCFAF4E),
                                              width: 1)),
                                      child: ValueListenableBuilder(
                                          valueListenable:
                                              profileController.notifieImage,
                                          builder: (context, value, child) {
                                            return InkWell(
                                              /* onTap: () async {
                                                final Map<String, dynamic>
                                                    notification = {
                                                  'title':
                                                      'Your Notification Title',
                                                  'body':
                                                      'Your Notification Body',
                                                };

                                                final Map<String, dynamic>
                                                    data = {
                                                  'click_action':
                                                      'FLUTTER_NOTIFICATION_CLICK',
                                                  'post_id': '7771',
                                                };

                                                final Map<String, dynamic>
                                                    payload = {
                                                  'notification': notification,
                                                  'data': data,
                                                  'to': '/topics/all_users',
                                                };

                                                final http.Response response =
                                                    await http.post(
                                                  Uri.parse(
                                                      'https://fcm.googleapis.com/fcm/send'),
                                                  headers: <String, String>{
                                                    'Content-Type':
                                                        'application/json',
                                                    'Authorization':
                                                        'key=AAAAI2WIOCE:APA91bGAgiWKrEZrqkr6Z73roNaC4vTpMttoK355vxXUZ4qY8Gs8PuVcvl25DkQVZ8CbA-xZ-IIiJMcqbKYwx-Op4OPRk_P-dByu9qBVmGKWx3PejAiSiKqOd0DuYPfD4T7b1Xq98cZ3',
                                                  },
                                                  body: jsonEncode(payload),
                                                );

                                                if (response.statusCode ==
                                                    200) {
                                                  print(
                                                      'Notification sent successfully');
                                                } else {
                                                  print(
                                                      'Failed to send notification. Status code: ${response.statusCode}');
                                                  print(
                                                      'Response body: ${response.body}');
                                                }
                                              }, */
                                              // onTap: () => Get.to(
                                              //     () => ViewProfile(
                                              //         bytes: profileController
                                              //                     .profileModel
                                              //                     .value
                                              //                     .image !=
                                              //                 null
                                              //             ? profileController
                                              //                 .profileImageURL
                                              //                 .bodyBytes
                                              //             : null),
                                              //     transition: Transition
                                              //         .circularReveal),
                                              child: profileController
                                                          .profileModel
                                                          .value
                                                          .image !=
                                                      null
                                                  ? CircleAvatar(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      backgroundImage:
                                                          MemoryImage(
                                                              profileController
                                                                  .profileImageURL
                                                                  .bodyBytes),
                                                      radius: Get.height * 0.06,
                                                    )
                                                  : CircleAvatar(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      backgroundImage:
                                                          AssetImage(
                                                        Images.profile,
                                                      ),
                                                      radius: Get.height * 0.06,
                                                    ),
                                            );
                                          }),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        ImageUploadHelper().showCropImagePicker(
                                            context, true, (p0) {
                                          if (p0 != null) {
                                            print("path ==> $p0");
                                            profileController.path = p0;
                                            Get.to(() => ChooseProfilePhoto(),
                                                binding: InitialBinding());
                                          }
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.white,
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF0E2ED4),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2)),
                                          child: const Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${profileController.profileModel.value.firstName ?? ""} ${profileController.profileModel.value.lastName ?? ""}",
                                    style: nameLabel,
                                    textScaleFactor: 1.0,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                      profileController
                                              .profileModel.value.phoneNumber ??
                                          "",
                                      style: nameDesc),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: Get.height * 0.04),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 30),
                        child: Text(
                          'settings'.tr,
                          style: settingsTitle,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildSettingItemsList(),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'change_lang'.tr,
                                  style: smText,
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    ChangeLanguage().changeLanguage();
                                  },
                                  child: Text(
                                    'ksw'.tr,
                                    style: boldText,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    deleteAccountBottomSheet();
                                  },
                                  child: Text(
                                    'delete_account'.tr,
                                    style: deleteText,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  width: 122,
                                  child: TextButton(
                                    style: btnGrey,
                                    onPressed: () {
                                      SetSharedPref().clearData();
                                      Get.offAll(() => SignIn(),
                                          binding: InitialBinding());
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              'sign_out'.tr,
                                              style: btnGreyText,
                                            ),
                                          ),
                                          Image.asset(
                                              'assets/btn_arrow_right.png'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () =>
                                  _navigateToScreen(context, "about_tl"),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text('${"about_tl".tr} V.2', style: smText),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildSettingItemsList() {
    return Column(
      children: settingData.map((data) {
        return _buildSettingItem(data.text, data.image);
      }).toList(),
    );
  }

  Widget _buildSettingItem(String title, String image) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFF5F5F5)),
            color: const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextButton(
            onPressed: () {
              _navigateToScreen(context, title);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Image.asset(image,
                        color: const Color.fromRGBO(0, 0, 0, 0.3)),
                  ),
                  Expanded(
                    child: Text(
                      title.tr,
                      style: settingsLabel,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateToScreen(BuildContext context, String title) {
    switch (title) {
      case 'change_pin':
        profileController.pin1Controller.clear();
        profileController.pin2Controller.clear();
        Get.bottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            Container(
              margin: EdgeInsets.only(bottom: Get.height * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.close(1);
                        },
                        child: Image.asset('assets/close.png'),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.height * 0.03),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          children: [
                            Image.asset('assets/authentication.png'),
                            const SizedBox(height: 15),
                            Text('change_pin'.tr, style: charityLabel)
                          ],
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: Get.width * 0.53,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFF5F5F5)),
                                    color: const Color(0xFFD9D9D9),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Image.asset('assets/pin.png'),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller:
                                              profileController.pin1Controller,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(4)
                                          ],
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: 'new_pin'.tr,
                                            hintStyle: const TextStyle(
                                                color: Color(0xFF808080)),
                                            border: InputBorder.none,
                                          ),
                                          style: textFieldStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Container(
                                  width: Get.width * 0.53,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFF5F5F5)),
                                    color: const Color(0xFFD9D9D9),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Image.asset('assets/pin.png'),
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller:
                                              profileController.pin2Controller,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(4)
                                          ],
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: 'reenter_pin'.tr,
                                            hintStyle: const TextStyle(
                                                color: Color(0xFF808080)),
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
                                    if (profileController
                                            .pin1Controller.text.isEmpty ||
                                        profileController
                                            .pin2Controller.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "enter_pin_msg".tr);
                                    } else if (profileController
                                                .pin1Controller.text.length <
                                            4 ||
                                        profileController
                                                .pin2Controller.text.length <
                                            4) {
                                      Fluttertoast.showToast(
                                          msg: "enter_pin_msg1".tr);
                                    } else if (profileController
                                            .pin1Controller.text !=
                                        profileController.pin2Controller.text) {
                                      Fluttertoast.showToast(
                                          msg: "pin_missmatch".tr);
                                    } else {
                                      Get.close(1);
                                      profileController.sendOTP(
                                          profileController
                                              .profileModel.value.phoneNumber!);
                                      changePinAuthBottomSheet();
                                    }
                                  },
                                  style: btnGold2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'next'.tr,
                                          style: btnGoldText,
                                        ),
                                        const SizedBox(width: 10),
                                        Image.asset(
                                            'assets/btn_arrow_right.png'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
        break;
      case 'change_phone_num':
        profileController.newNumberController.clear();
        Get.bottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            Container(
              margin: EdgeInsets.only(bottom: Get.height * 0.05),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset('assets/close.png'),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.height * 0.03),
                    child: Column(
                      children: [
                        Image.asset('assets/phone.png'),
                        const SizedBox(height: 20),
                        Text('change_phone_num'.tr, style: charityLabel),
                        const SizedBox(height: 30.0),
                        Text(
                            '${"change".tr} *****${profileController.profileModel.value.phoneNumber!.substring(profileController.profileModel.value.phoneNumber!.length - 2)} ${"as_number".tr}',
                            style: desc),
                        const SizedBox(height: 50),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFF5F5F5)),
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              controller: profileController.newNumberController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10)
                              ],
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'new_number'.tr,
                                hintStyle:
                                    const TextStyle(color: Color(0xFF808080)),
                                border: InputBorder.none,
                              ),
                              style: textFieldStyle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: Get.width * 0.9,
                          child: TextButton(
                            onPressed: () {
                              if (profileController
                                  .newNumberController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "enter_number_msg".tr);
                              } else if (profileController
                                      .newNumberController.text.length <
                                  9) {
                                Fluttertoast.showToast(
                                    msg: "enter_valid_number_msg".tr);
                              } else {
                                profileController.sendOTP(profileController
                                    .newNumberController.text
                                    .trim());
                                Get.close(1);
                                authenticationBottomSheet();
                              }
                            },
                            style: btnGold2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 8.0),
                              child: Text(
                                'change'.tr,
                                style: btnGoldText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
        break;
      case 'terms_condition':
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: Get.height,
              alignment: Alignment.bottomCenter,
              child: Dialog(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 30),
                      // width: Get.width * 0.9,
                      height: Get.height,
                      child: Column(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(top: 10.0, bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'terms_condition'.tr,
                                  style: alertTitle,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  'terms_condition_desc'.tr,
                                  style: dialogTextSm,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40)
                        ],
                      ),
                    ),
                    Positioned(
                      top: 15,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          Get.close(1);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 30.0,
                          ),
                          child: Image.asset('assets/close.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        break;
      case 'privacy_policy':
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height - 125.0,
              alignment: Alignment.bottomCenter,
              child: Dialog(
                child: Stack(
                  children: [
                    SizedBox(
                      width: Get.width * 0.9,
                      height: Get.height,
                      child: Column(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(top: 30.0, bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'privacy_policy'.tr,
                                  style: alertTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  'privacy_policy_desc'.tr,
                                  style: dialogTextSm,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 15.0,
                          ),
                          child: Image.asset('assets/close.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        break;
      case 'about_tl':
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height - 125.0,
              alignment: Alignment.bottomCenter,
              child: Dialog(
                child: Stack(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height,
                      child: Column(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.only(top: 30.0, bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'about_tl'.tr,
                                  style: alertTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: Text(
                                  'about_tl_desc'.tr,
                                  style: dialogTextSm,
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 15.0,
                          ),
                          child: Image.asset('assets/close.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
        break;
      default:
        break;
    }
  }

  void deleteAccountBottomSheet() {
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        Container(
            margin: EdgeInsets.only(bottom: Get.height * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.close(1);
                      },
                      child: Image.asset('assets/close.png'),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: Get.width * 0.5,
                        child: Text(
                          'delete_account_desc'.tr,
                          style: changeLabel,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height * 0.07,
                        child: TextButton(
                          onPressed: () {
                            Get.close(1);
                          },
                          style: btnGrey,
                          child: Text(
                            'no'.tr,
                            style: btnGreyText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      SizedBox(
                        width: double.infinity,
                        height: Get.height * 0.07,
                        child: TextButton(
                          onPressed: () {
                            profileController.deleteAccount();
                          },
                          style: btnRed,
                          child: Text(
                            'yes'.tr,
                            style: yesText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  void authenticationBottomSheet() {
    profileController.otpController.clear();
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        Container(
          margin: const EdgeInsets.only(bottom: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.close(1);
                    },
                    child: Image.asset('assets/close.png'),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.height * 0.03),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/authentication.png'),
                        const SizedBox(height: 15),
                        Text('authentication'.tr, style: charityLabel)
                      ],
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Column(
                      children: [
                        Text(
                            '${"enter_otp_to".tr} *****${profileController.newNumberController.text.substring(profileController.newNumberController.text.length - 2)}',
                            style: desc),
                        const SizedBox(height: 50),
                        Row(
                          children: [
                            Container(
                              width: Get.width * 0.58,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFF5F5F5)),
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Image.asset('assets/pin.png'),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller:
                                          profileController.otpController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(6)
                                      ],
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'enter_otp_field'.tr,
                                        hintStyle: const TextStyle(
                                            color: Color(0xFF808080)),
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
                                if (profileController
                                    .otpController.text.isEmpty) {
                                  Fluttertoast.showToast(msg: "enter_otp".tr);
                                } else if (profileController
                                        .otpController.text.length <
                                    6) {
                                  Fluttertoast.showToast(
                                      msg: "otp_digit_msg".tr);
                                } else {
                                  profileController.verifyOTP(
                                      true,
                                      profileController
                                          .newNumberController.text);
                                  Get.close(1);
                                }
                              },
                              style: btnGold2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'save'.tr,
                                      style: btnGoldText,
                                    ),
                                    const SizedBox(width: 10),
                                    Image.asset('assets/btn_arrow_right.png'),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void changePinAuthBottomSheet() {
    profileController.otpController.clear();
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        Container(
          margin: EdgeInsets.only(bottom: Get.height * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.close(1);
                    },
                    child: Image.asset('assets/close.png'),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: Get.height * 0.025),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/authentication.png'),
                        const SizedBox(height: 15),
                        Text('change_pin'.tr, style: charityLabel)
                      ],
                    ),
                    SizedBox(height: Get.height * 0.03),
                    Column(
                      children: [
                        Text(
                            '${"enter_otp_to".tr} *****${profileController.profileModel.value.phoneNumber!.substring(profileController.profileModel.value.phoneNumber!.length - 2)}',
                            style: desc),
                        const SizedBox(height: 50),
                        Row(
                          children: [
                            Container(
                              width: Get.width * 0.55,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFF5F5F5)),
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Image.asset('assets/pin.png'),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller:
                                          profileController.otpController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(6)
                                      ],
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'enter_otp_field'.tr,
                                        hintStyle: const TextStyle(
                                            color: Color(0xFF808080)),
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
                                if (profileController
                                    .otpController.text.isEmpty) {
                                  Fluttertoast.showToast(msg: "enter_otp".tr);
                                } else if (profileController
                                        .otpController.text.length <
                                    6) {
                                  Fluttertoast.showToast(
                                      msg: "otp_digit_msg".tr);
                                } else {
                                  profileController.verifyOTP(
                                      false,
                                      profileController
                                          .profileModel.value.phoneNumber!);
                                }
                              },
                              style: btnGold2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'next'.tr,
                                      style: btnGoldText,
                                    ),
                                    const SizedBox(width: 10),
                                    Image.asset('assets/btn_arrow_right.png'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
