import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/signin/controller/signin_controller.dart';
import 'package:tl_customer/screens/signup/component/register.dart';
import 'package:tl_customer/widget/loader_widget.dart';

import 'package:tl_customer/widget/translate_language.dart';
import '../../../../src/pages/styles.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SigninController signinController = Get.find<SigninController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(
        () => signinController.isLoading.value
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
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Image.asset('assets/signin.png'),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  'sign_in'.tr,
                                  style: label,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  'login_desc'.tr,
                                  style: desc,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            // height: Get.height * 0.06,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            width: Get.width,
                            child: signinController.showMsg.value == false
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
                                            "signin_error".tr,
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
                          Container(
                            margin: const EdgeInsets.only(bottom: 5.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFFF5F5F5)),
                              color: const Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Image.asset('assets/ion_keypad.png'),
                                  Expanded(
                                    child: TextField(
                                      controller:
                                          signinController.numberController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: 'phone_number'.tr,
                                        hintStyle: const TextStyle(
                                            color: Color(0xFF808080)),
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                      ),
                                      style: textFieldStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5.0),
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
                                          controller: signinController
                                              .passwordController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            LengthLimitingTextInputFormatter(4),
                                          ],
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: 'pin'.tr,
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
                              ),
                              TextButton(
                                onPressed: () {
                                  signinController.login();
                                },
                                style: btnGold,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 13, vertical: 5.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                          'sign_in'.tr,
                                          style: btnGoldText,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'forgot_pin'.tr,
                                style: forgotLabel,
                              ),
                              TextButton(
                                onPressed: () {
                                  if (signinController
                                      .numberController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "enter_number_msg".tr);
                                  } else if (signinController
                                          .numberController.text
                                          .trim()
                                          .length <
                                      9) {
                                    Fluttertoast.showToast(
                                        msg: "enter_valid_number_msg".tr);
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('reset_pin'.tr),
                                          content: Text('reset_conf'.tr),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Get.close(1);
                                                signinController.resetPin();
                                              },
                                              child: Text(
                                                'reset'.tr,
                                                // style: resetBtnText,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Get.close(1);
                                              },
                                              child: Text('cancel'.tr),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Text('reset'.tr),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20.0),
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
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.06,
                            child: TextButton(
                              style: btnGrey,
                              onPressed: () {
                                Get.to(() => Register(),
                                    binding: InitialBinding());
                              },
                              child: Text('register'.tr, style: btnGreyText),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.075,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
