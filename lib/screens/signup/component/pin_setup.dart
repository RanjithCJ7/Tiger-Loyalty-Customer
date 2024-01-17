import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tl_customer/screens/signup/controller/signup_controller.dart';
import 'package:tl_customer/widget/loader_widget.dart';

import '../../../../src/pages/styles.dart';

// ignore: must_be_immutable
class PinSetup extends StatelessWidget {
  bool isReset;
  String token;
  PinSetup({required this.isReset, required this.token});

  SignupController signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    signupController.pinMatch.value == false;

    return Scaffold(
      body: Obx(
        () => signupController.isLoading.value
            ? const LoaderWidget()
            : Center(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.08),
                      child: Column(
                        children: [
                          Image.asset('assets/pin_setup.png'),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'pin_setup'.tr,
                            style: label,
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            'pin_setup_desc'.tr,
                            style: desc,
                          ),
                          SizedBox(height: size.height * 0.03),
                          signupController.pinMatch.value == false
                              ? SizedBox(height: Get.height * 0.032)
                              : Column(
                                  children: [
                                    IntrinsicHeight(
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
                                          Text(
                                            "pin_missmatch".tr,
                                            style: const TextStyle(
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15,
                                              color: Colors.red,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                  ],
                                ),
                          Row(
                            children: [
                              Container(
                                width: size.width * 0.5,
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
                                            signupController.pin1Controller,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          hintText: 'new_pin'.tr,
                                          hintStyle: const TextStyle(
                                              color: Color(0xFF808080)),
                                          border: InputBorder.none,
                                        ),
                                        style: textFieldStyle.copyWith(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Row(
                            children: [
                              Container(
                                width: size.width * 0.5,
                                // margin: EdgeInsets.only(right: 5.0),
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
                                            signupController.pin2Controller,
                                        onChanged: (value) {
                                          verifyPIN();
                                        },
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          LengthLimitingTextInputFormatter(4),
                                        ],
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          hintText: 'reenter_pin'.tr,
                                          hintStyle: const TextStyle(
                                              color: Color(0xFF808080)),
                                          border: InputBorder.none,
                                        ),
                                        style: textFieldStyle.copyWith(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: size.width * 0.01),
                              TextButton(
                                onPressed: () {
                                  if (signupController
                                          .pin1Controller.text.isEmpty ||
                                      signupController
                                          .pin2Controller.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "enter_pin_msg".tr);
                                  } else if (signupController
                                              .pin1Controller.text.length <
                                          4 ||
                                      signupController
                                              .pin2Controller.text.length <
                                          4) {
                                    Fluttertoast.showToast(
                                        msg: "enter_pin_msg1".tr);
                                  } else {
                                    if (signupController.pinMatch.value ==
                                        true) {
                                    } else {
                                      if (isReset) {
                                        signupController.resetPIN(
                                            isReset, token);
                                      } else {
                                        signupController.setPin();
                                      }
                                    }
                                  }
                                },
                                style: btnGold,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          'next'.tr,
                                          style: btnGoldText,
                                        ),
                                      ),
                                      Image.asset('assets/btn_arrow_right.png'),
                                    ],
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

  void verifyPIN() {
    if (signupController.pin1Controller.text.isNotEmpty &&
        signupController.pin2Controller.text.isNotEmpty &&
        signupController.pin1Controller.text !=
            signupController.pin2Controller.text) {
      signupController.pinMatch.value = true;
    } else if (signupController.pin1Controller.text ==
        signupController.pin2Controller.text) {
      signupController.pinMatch.value = false;
    } else if (signupController.pin2Controller.text.isEmpty) {
      signupController.pinMatch.value = false;
    }
  }
}

class CustomTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String text = newValue.text.replaceAll(RegExp(r'\D'), '');

    final StringBuffer newText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 3 == 0) {
        newText.write('-');
      }
      newText.write(text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
