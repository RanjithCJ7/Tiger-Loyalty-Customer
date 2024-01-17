import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/signup/controller/signup_controller.dart';
import 'package:tl_customer/screens/signup/component/authentication.dart';
import 'package:tl_customer/screens/signin/component/signin.dart';
import 'package:tl_customer/widget/loader_widget.dart';

import '../../../../src/pages/styles.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  SignupController signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => signupController.isLoading.value
              ? const LoaderWidget()
              : Center(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 15.0),
                                  child: Image.asset('assets/reg_user.png'),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 20.0),
                                  child: Text(
                                    'register'.tr,
                                    style: label,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 5.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFF5F5F5)),
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                controller:
                                    signupController.firstNameController,
                                decoration: InputDecoration(
                                  hintText: 'first_name'.tr,
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF808080)),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(20),
                                ),
                                style: textFieldStyle,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 5.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFF5F5F5)),
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                controller:
                                    signupController.lasttNameController,
                                decoration: InputDecoration(
                                  hintText: 'last_name'.tr,
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF808080)),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(20),
                                ),
                                style: textFieldStyle,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "what_gender".tr,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            signupController.gender.value =
                                                'Female';
                                          });
                                        },
                                        style: signupController.gender.value ==
                                                'Female'
                                            ? selectBtn
                                            : deSelectBtn,
                                        child: Row(
                                          children: [
                                            Text("female".tr,
                                                style: signupController
                                                            .gender.value ==
                                                        'Female'
                                                    ? selectBtnBold
                                                    : selectBtnSm),
                                            if (signupController.gender.value ==
                                                'Female')
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Image.asset(
                                                    'assets/tick.png'),
                                              ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 10.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          signupController.gender.value =
                                              'Male';
                                        },
                                        style: signupController.gender.value ==
                                                'Male'
                                            ? selectBtn
                                            : deSelectBtn,
                                        child: Row(
                                          children: [
                                            Text(
                                              "male".tr,
                                              style: signupController
                                                          .gender.value ==
                                                      'Male'
                                                  ? selectBtnBold
                                                  : selectBtnSm,
                                            ),
                                            if (signupController.gender.value ==
                                                'Male')
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Image.asset(
                                                    'assets/tick.png'),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 5.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFF5F5F5)),
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextField(
                                controller: signupController.numberController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: InputDecoration(
                                  hintText: 'phone_number'.tr,
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF808080)),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(20),
                                ),
                                style: textFieldStyle,
                              ),
                            ),
                            SizedBox(height: Get.height * 0.014),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  visualDensity: const VisualDensity(
                                      vertical: 0, horizontal: -4),
                                  value: signupController.isTermChecked.value,
                                  onChanged: (value) {
                                    signupController.isTermChecked.value =
                                        !signupController.isTermChecked.value;
                                  },
                                  checkColor: Colors.white,
                                  activeColor: Colors.black,
                                ),
                                Text("i_accept".tr),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          alignment: Alignment.bottomCenter,
                                          child: Dialog(
                                            child: Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 30.0,
                                                              bottom: 20.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'terms_condition'
                                                                .tr,
                                                            style: alertTitle,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child:
                                                          SingleChildScrollView(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 30.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      30),
                                                          child: Text(
                                                            'terms_condition_desc'
                                                                .tr,
                                                            style: dialogTextSm,
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 50,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              30.0),
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Get.close(1);
                                                          signupController
                                                              .isTermChecked
                                                              .value = true;
                                                        },
                                                        style: btnGold2,
                                                        child: Text(
                                                          'proceed'.tr,
                                                          style: btnGoldText2,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Positioned(
                                                  top: 5,
                                                  right: 5,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Get.close(1);
                                                    },
                                                    child: Image.asset(
                                                        'assets/close.png'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Text(
                                      'terms_condition'.tr,
                                      style: resetBtnText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                signupController.nextFuncation();
                              },
                              style: btnGold2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'register'.tr,
                                      style: btnGoldText2.copyWith(
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
