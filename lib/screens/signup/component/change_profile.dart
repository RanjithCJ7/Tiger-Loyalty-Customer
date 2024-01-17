import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/bottomTab/component/bottom_tab.dart';
import 'package:tl_customer/screens/signin/component/signin.dart';
import 'package:tl_customer/screens/signup/component/choose_photo.dart';
import 'package:tl_customer/screens/signup/controller/signup_controller.dart';
import 'package:tl_customer/widget/loader_widget.dart';

import 'package:tl_customer/widget/select_image.dart';
import '../../../src/pages/styles.dart';

class ChangeProfile extends StatefulWidget {
  String token;

  ChangeProfile({super.key, required this.token});

  @override
  // ignore: library_private_types_in_public_api
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  SignupController signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => signupController.isLoading.value
            ? const LoaderWidget()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xFFCFAF4E), width: 1),
                    ),
                    child: signupController.path.path != "null"
                        ? CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                FileImage(File(signupController.path.path)),
                            radius: Get.height * 0.06,
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              Images.profile,
                            ),
                            radius: Get.height * 0.06,
                          ),
                  ),
                  SizedBox(height: Get.height * 0.06),
                  Text('congratulations'.tr, style: label),
                  SizedBox(height: Get.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('tiger_msg1'.tr, style: desc),
                      const SizedBox(width: 5),
                      Text('tigerian'.tr, style: descGold),
                    ],
                  ),
                  Text('tiger_msg2'.tr, style: desc),
                  SizedBox(height: Get.height * 0.02),
                  Text('happy_hunting'.tr, style: label_sm),
                  SizedBox(height: Get.height * 0.04),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => SignIn(), binding: InitialBinding());
                        },
                        style: btnGrey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'sign_in'.tr,
                                style: btnGoldText,
                              ),
                              const SizedBox(width: 10),
                              Image.asset('assets/btn_arrow_right.png'),
                            ],
                          ),
                        ),
                      ),
                      const Spacer()
                    ],
                  ),
                  const SizedBox(height: 70),
                  Text(
                    'change_profile_pic'.tr,
                    style: desc,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: btnGrey,
                        onPressed: () {
                          ImageUploadHelper().imgFromGallery().then((value) {
                            if (value != null) {
                              ImageUploadHelper().cropImage(value, (p1) {
                                if (p1!.path != "null") {
                                  setState(() {
                                    signupController.path = p1;
                                  });
                                  Get.to(() => ChoosePhoto(token: widget.token),
                                          binding: InitialBinding())!
                                      .then((value) {
                                    setState(() {});
                                  });
                                }
                              }, true);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Image.asset('assets/choose_photo.png'),
                              const SizedBox(width: 10),
                              Text('choose_photo'.tr, style: desc2),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        style: btnGrey,
                        onPressed: () {
                          ImageUploadHelper().imgFromCamera().then((value) {
                            if (value != null) {
                              ImageUploadHelper().cropImage(value, (p1) {
                                if (p1!.path != "null") {
                                  setState(() {
                                    signupController.path = p1;
                                  });
                                  Get.to(() => ChoosePhoto(token: widget.token),
                                          binding: InitialBinding())!
                                      .then((value) {
                                    setState(() {});
                                  });
                                }
                              }, true);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Image.asset('assets/take_photo.png'),
                              const SizedBox(width: 10),
                              Text('take_picture'.tr, style: desc2),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
