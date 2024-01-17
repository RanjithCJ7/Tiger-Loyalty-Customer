import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/signup/controller/signup_controller.dart';
import 'package:tl_customer/screens/signin/component/signin.dart';
import 'package:tl_customer/widget/loader_widget.dart';

import '../../../src/pages/styles.dart';

// ignore: must_be_immutable
class Authentication extends StatefulWidget {
  bool isReset;
  String? email;
  Authentication({super.key, required this.isReset, this.email});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  SignupController signupController = Get.find<SignupController>();

  @override
  void initState() {
    signupController.showTimer.value = false;
    signupController.timer?.cancel();
    signupController.secondsRemaining = 120.obs;
    super.initState();
  }

  @override
  void dispose() {
    signupController.showTimer.value = false;
    signupController.timer?.cancel();
    signupController.secondsRemaining = 120.obs;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    signupController.otpController.clear();

    return Scaffold(
      body: Obx(
        () => signupController.isLoading.value
            ? const LoaderWidget()
            : Center(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 15.0),
                                child: Image.asset('assets/auth.png'),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  'authentication'.tr,
                                  style: label,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(bottom: 30.0),
                                child: Text(
                                  'enter_otp_from_mail'.tr,
                                  style: desc,
                                ),
                              ),
                              Container(
                                // height: Get.height * 0.06,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                width: Get.width,
                                child: signupController.showTimer.value == false
                                    ? const SizedBox()
                                    : IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const VerticalDivider(
                                              color: Colors.red,
                                              thickness: 3,
                                              width: 0,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.75,
                                              child: Text(
                                                "${"wrong_otp".tr} (${'${signupController.secondsRemaining ~/ 60}:${(signupController.secondsRemaining % 60).toString().padLeft(2, '0')}'})",
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  fontFamily: "Inter",
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 15,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 5.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xFFF5F5F5)),
                                        color: const Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child:
                                                Image.asset('assets/pin.png'),
                                          ),
                                          Expanded(
                                            child: TextField(
                                              controller: signupController
                                                  .otpController,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                LengthLimitingTextInputFormatter(
                                                    6),
                                              ],
                                              obscureText: true,
                                              decoration: const InputDecoration(
                                                hintText: '******',
                                                hintStyle: TextStyle(
                                                    color: Color(0xFF808080),
                                                    letterSpacing: 4.0),
                                                border: InputBorder.none,
                                              ),
                                              obscuringCharacter: '*',
                                              style: textFieldStyle.copyWith(
                                                  letterSpacing: 4.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (signupController
                                          .otpController.text.isEmpty) {
                                        Fluttertoast.showToast(
                                            msg: "enter_otp".tr);
                                      } else if (signupController
                                              .otpController.text.length <
                                          6) {
                                        Fluttertoast.showToast(
                                            msg: "otp_digit_msg".tr);
                                      } else {
                                        if (widget.isReset) {
                                          signupController
                                              .verifyFogetOTP(widget.email!);
                                        } else {
                                          signupController
                                              .verifyOTP(widget.isReset);
                                        }
                                      }
                                    },
                                    style: btnGold,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 13, vertical: 8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                              'next'.tr,
                                              style: btnGoldText,
                                            ),
                                          ),
                                          Image.asset(
                                              'assets/btn_arrow_right.png'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'not_received'.tr,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      signupController.resendOTP(widget.email ??
                                          signupController.numberController.text
                                              .trim());
                                    },
                                    child: Text('resend'.tr),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 25.0, bottom: 30.0),
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
                                margin: const EdgeInsets.only(bottom: 50.0),
                                width: double.infinity,
                                height: 50,
                                child: TextButton(
                                  style: btnGrey,
                                  onPressed: () {
                                    Get.offAll(() => SignIn(),
                                        binding: InitialBinding());
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 7.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'sign_in'.tr,
                                          style: btnGreyText.copyWith(
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
