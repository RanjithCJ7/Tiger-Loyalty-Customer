import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/screens/bottomTab/controller/bottom_tab_controller.dart';

import 'package:tl_customer/screens/notification/controller/notification_controller.dart';
import 'package:tl_customer/screens/profile/controller/profile_controller.dart';
import 'package:tl_customer/screens/promo/controller/promo_controller.dart';
import 'package:tl_customer/screens/rewards/controller/rewards_controller.dart';
import 'package:tl_customer/src/pages/styles.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  BottomTabController bottomTabController = Get.put(BottomTabController());
  NotificationController notificationController =
      Get.put(NotificationController());

  RewardsController rewardsController = Get.find<RewardsController>();

  @override
  void initState() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<RewardsController>(() => RewardsController());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: bottomTabController.changeTab,
          builder: (context, value, child) {
            return BottomNavigationBar(
              currentIndex: bottomTabController.index.value,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFFFBFBFB),
              selectedItemColor: Colors.black,
              unselectedItemColor: const Color(0xFFB0B0B0),
              selectedFontSize: 14,
              unselectedFontSize: 14,
              onTap: (value) {
                Get.lazyPut<ProfileController>(() => ProfileController());
                Get.lazyPut<RewardsController>(() => RewardsController());
                Get.lazyPut<PromoController>(() => PromoController());

                if (value == 1) {
                  bottomTabController.openCamera();
                } else {
                  setState(() {
                    bottomTabController.index.value = value;
                  });
                }
              },
              items: [
                BottomNavigationBarItem(
                  label: 'rewards'.tr,
                  tooltip: 'rewards'.tr,
                  icon: Image.asset(
                    Images.rewardsImg,
                    color: bottomTabController.index.value == 0
                        ? Colors.black
                        : const Color(0xFFB0B0B0),
                    height: Get.height * 0.025,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'redeem'.tr,
                  icon: Image.asset(
                    Images.redeemIcon,
                    color: bottomTabController.index.value == 1
                        ? Colors.black
                        : const Color(0xFFB0B0B0),
                    height: Get.height * 0.025,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'brands'.tr,
                  icon: Image.asset(
                    Images.brandsImg,
                    color: bottomTabController.index.value == 2
                        ? Colors.black
                        : const Color(0xFFB0B0B0),
                    height: Get.height * 0.025,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'profile'.tr,
                  icon: Image.asset(
                    Images.profileImg,
                    color: bottomTabController.index.value == 3
                        ? Colors.black
                        : const Color(0xFFB0B0B0),
                    height: Get.height * 0.025,
                  ),
                ),
              ],
            );
          }),
      body: ValueListenableBuilder(
          valueListenable: bottomTabController.changeTab,
          builder: (context, value, child) {
            return bottomTabController.screen[bottomTabController.index.value];
          }),
    );
  }
}

class FailedTransaction extends StatelessWidget {
  const FailedTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/warning.png'),
            const SizedBox(height: 15),
            Text('failed'.tr, style: alertTitle),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width * 0.8,
              height: Get.height * 0.07,
              child: Text(
                'transaction_failed'.tr,
                style: greyText2,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: Get.width * 0.8,
              height: Get.height * 0.07,
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                style: btnGrey,
                child: Text('try_again'.tr, style: label_sm2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
