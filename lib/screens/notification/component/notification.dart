import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/const/my_appbar.dart';
import 'package:tl_customer/screens/bottomTab/controller/bottom_tab_controller.dart';
import 'package:tl_customer/screens/notification/controller/notification_controller.dart';
import 'package:tl_customer/src/pages/styles.dart';
import 'package:tl_customer/widget/loader_widget.dart';

class NotificaionModel {
  String title, desc, time;
  NotificaionModel({
    required this.title,
    required this.desc,
    required this.time,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var tabs = [
    {"name": "rewards".tr, "icon": Images.rewardsIcon},
    {"name": "redeem".tr, "icon": Images.redeemIcon},
    {"name": "brands".tr, "icon": Images.brandsIcon},
    {"name": "profile".tr, "icon": Images.profileIcon},
  ];
  String selectedTab = "rewards".tr;
  NotificationController notificationController =
      Get.put(NotificationController());
  BottomTabController bottomTabController = Get.find<BottomTabController>();

  @override
  void initState() {
    notificationController.fetchNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: My_AppBar(context,
          isRedirect: true,
          title: Text('notifications'.tr,
              style: label.copyWith(color: Colors.black))),
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
                Get.back();
                if (value == 1) {
                  bottomTabController.index.value = 0;
                  bottomTabController.openCamera();
                } else {
                  setState(() {
                    bottomTabController.index.value = value;
                  });
                }
                bottomTabController.changeTab.notifyListeners();
              },
              items: [
                BottomNavigationBarItem(
                  label: 'rewards'.tr,
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
      body: Obx(
        () => notificationController.isLoading.value
            ? const LoaderWidget()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          notificationController.readAllNotification();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: const Color(0xFFCA1818)),
                          child: Text(
                            "clear_all".tr,
                            style: const TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            notificationController.notificationList.length,
                        separatorBuilder: (context, index) => Divider(
                          height: size.height * 0.01,
                          color: Colors.white,
                        ),
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                visualDensity: const VisualDensity(
                                    horizontal: 0, vertical: -4),
                                title: Text(
                                  notificationController
                                          .notificationList[index].title ??
                                      "",
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w800,
                                      color: notificationController
                                                  .notificationList[index]
                                                  .read ==
                                              true
                                          ? const Color(0xFF808080)
                                          : Colors.black,
                                      fontSize: 16),
                                ),
                                trailing: Text(
                                  notificationController.notificationList[index]
                                              .createdDt !=
                                          null
                                      ? getNotificationText(DateTime.parse(
                                          notificationController
                                              .notificationList[index]
                                              .createdDt!))
                                      : "",
                                  style: const TextStyle(
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF808080),
                                      fontSize: 12),
                                ),
                              ),
                              Text(
                                notificationController
                                        .notificationList[index].description ??
                                    "",
                                style: const TextStyle(
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF808080),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
      /* bottomNavigationBar: Container(
        height: size.height * 0.07,
        color: const Color(0xFFD9D9D9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: tabs
              .map((e) => InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = e["name"]!;
                      });
                      if (e["name"] == "Profile") {
                        bottomTabController.index.value = 3;
                        bottomTabController.changeTab.notifyListeners();
                        Get.back();
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          e["icon"]!,
                          height: 20,
                          color: e["name"]! == selectedTab
                              ? Colors.black
                              : const Color(0xFFB0B0B0),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          e["name"]!,
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: e["name"]! == selectedTab
                                  ? Colors.black
                                  : const Color(0xFFB0B0B0)),
                        ),
                        SizedBox(height: size.height * 0.01),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
     */
    );
  }

  String getNotificationText(DateTime date) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'now'.tr;
    } else if (difference.inMinutes < 60) {
      int minutes = difference.inMinutes;
      return '$minutes ${minutes == 1 ? 'min_time'.tr : 'min_time'.tr}';
    } else if (difference.inHours < 24) {
      int hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour'.tr : 'hours'.tr}';
    } else if (difference.inDays == 1) {
      return 'Yesterday'.tr;
    } else if (difference.inDays < 7) {
      int days = difference.inDays;
      return '$days ${days == 1 ? 'day'.tr : 'days'.tr}';
    } else if (difference.inDays < 365) {
      int weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week'.tr : 'weeks'.tr}';
    } else {
      int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year'.tr : 'years'.tr}';
    }
  }
}
