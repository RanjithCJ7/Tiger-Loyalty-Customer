import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/newUser/controller/newuser_controller.dart';
import 'package:tl_customer/screens/signin/component/signin.dart';
import '../../../src/pages/styles.dart';

// ignore: camel_case_types
class Home_NewUser extends StatefulWidget {
  const Home_NewUser({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Home_NewUserState createState() => _Home_NewUserState();
}

// ignore: camel_case_types
class _Home_NewUserState extends State<Home_NewUser> {
  PageController pageController = PageController(viewportFraction: 0.9);
  List page = [
    {"title": "intro1", "desc": "intro1_desc"},
    {"title": "intro2", "desc": "intro2_desc"},
    {"title": "intro3", "desc": "intro3_desc"}
  ];
  NewuserController newUserController = Get.find<NewuserController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.04),
              SizedBox(
                width: Get.width,
                height: Get.height * 0.5,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: page.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: Get.width * 0.8,
                      height: Get.width * 0.9,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/welcome.png',
                            ),
                            const SizedBox(height: 30.0),
                            Text(
                              "${page[index]["title"]}".tr,
                              style: welcomeTitle,
                            ),
                            const SizedBox(height: 20.0),
                            SizedBox(
                              width: Get.width * 0.7,
                              child: Text(
                                "${page[index]["desc"]}".tr,
                                style: welcomeDesc,
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Text('get_started'.tr, style: startText),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: size.width,
                      height: 44,
                      child: TextButton(
                        style: btnGrey,
                        onPressed: () {
                          Get.to(() => SignIn(), binding: InitialBinding());
                        },
                        child: Text('sign_regis'.tr, style: startBtnText),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: size.width,
                      height: 44,
                      child: TextButton(
                        style: btnGrey,
                        onPressed: () async {
                          try {
                            var status = await Permission.camera.status;
                            if (status.isPermanentlyDenied) {
                              openAppSettings();
                            } else if (!status.isGranted) {
                              status = await Permission.camera.request();
                              if (status.isGranted) {
                                newUserController.scanQRBottomSheet();
                              } else {
                                openAppSettings();
                              }
                            } else {
                              newUserController.scanQRBottomSheet();
                            }
                          } catch (e) {
                            rethrow;
                          }
                        },
                        child: Text('make_payment'.tr, style: startBtnText),
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
