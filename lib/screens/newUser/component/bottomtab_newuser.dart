import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/const/constant.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/newUser/component/brand_newuser.dart';
import 'package:tl_customer/screens/newUser/component/reward_newuser.dart';
import 'package:tl_customer/screens/newUser/controller/brands_newuser.dart';
import 'package:tl_customer/screens/signup/component/register.dart';
import 'package:tl_customer/src/pages/styles.dart';

class BottomTabNewUser extends StatefulWidget {
  const BottomTabNewUser({super.key});

  @override
  State<BottomTabNewUser> createState() => _BottomTabNewUserState();
}

class _BottomTabNewUserState extends State<BottomTabNewUser> {
  int index = 0;
  var screen = [
    const RewardNewUser(),
    const RewardNewUser(),
    BrandsNewUser(),
    BrandsNewUser(),
  ];

  @override
  void initState() {
    Get.lazyPut<BrandsNewUserController>(() => BrandsNewUserController());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFBFBFB),
        selectedItemColor: Colors.black,
        unselectedItemColor: const Color(0xFFB0B0B0),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          Get.lazyPut<BrandsNewUserController>(() => BrandsNewUserController());
          /* if (value == 1) {
            bottomTabController.openCamera();
          } else {
            setState(() {
              bottomTabController.index.value = value;
            });
          } */
          setState(() {
            if (value == 1 || value == 3) {
              actionBottomSheet();
            } else {
              index = value;
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'rewards'.tr,
            tooltip: 'rewards'.tr,
            icon: Image.asset(
              Images.rewardsImg,
              color: index == 0 ? Colors.black : const Color(0xFFB0B0B0),
              height: Get.height * 0.025,
            ),
          ),
          BottomNavigationBarItem(
            label: 'redeem'.tr,
            icon: Image.asset(
              Images.redeemIcon,
              color: index == 1 ? Colors.black : const Color(0xFFB0B0B0),
              height: Get.height * 0.025,
            ),
          ),
          BottomNavigationBarItem(
            label: 'brands'.tr,
            icon: Image.asset(
              Images.brandsImg,
              color: index == 2 ? Colors.black : const Color(0xFFB0B0B0),
              height: Get.height * 0.025,
            ),
          ),
          BottomNavigationBarItem(
            label: 'profile'.tr,
            icon: Image.asset(
              Images.profileImg,
              color: index == 3 ? Colors.black : const Color(0xFFB0B0B0),
              height: Get.height * 0.025,
            ),
          ),
        ],
      ),
      body: screen[index],
    );
  }

  actionBottomSheet() {
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                margin: EdgeInsets.symmetric(horizontal: Get.height * 0.02),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'register'.tr,
                      style: charityLabel,
                    ),
                    const SizedBox(height: 30.0),
                    Column(
                      children: [
                        SizedBox(
                          width: Get.width * 0.5,
                          child: Text(
                            '${DateTime.now().add(const Duration(days: 7)).difference(DateTime.parse(Params.tokenExpiry)).inDays} ${"days_remaining".tr}',
                            style: desc,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: Get.width * 0.8,
                          child: TextButton(
                            onPressed: () {
                              SetSharedPref().clearData();
                              Get.offAll(() => Register(),
                                  binding: InitialBinding());
                            },
                            style: btnGrey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 8.0),
                              child: Text(
                                'complete_register'.tr,
                                style: btnGreyText,
                                textAlign: TextAlign.center,
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
        ));
  }
}
