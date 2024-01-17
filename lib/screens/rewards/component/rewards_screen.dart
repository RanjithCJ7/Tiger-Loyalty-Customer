import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/const/my_appbar.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:intl/intl.dart';
import 'package:tl_customer/screens/profile/controller/profile_controller.dart';
import 'package:tl_customer/screens/rewards/controller/rewards_controller.dart';
import 'package:tl_customer/screens/rewards/model/reward_points_model.dart';
import 'package:tl_customer/screens/rewards/model/transation_model.dart';
import 'package:tl_customer/screens/signup/component/register.dart';

import 'package:tl_customer/src/pages/submit.dart';
import 'package:tl_customer/widget/loader_widget.dart';
import '../../../src/pages/styles.dart';

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreen_State createState() => _RewardsScreen_State();
}

class _RewardsScreen_State extends State<RewardsScreen> {
  ProfileController profileController = Get.find<ProfileController>();
  RewardsController rewardsController = Get.find<RewardsController>();

  @override
  void initState() {
    rewardsController.getRewardsPoints();
    rewardsController.getRewardSummary("");
    rewardsController.selectedCategory = 'business_category'.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: My_AppBar(
        context,
        title: Obx(
          () => profileController.isLoading.value
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    '${"hello".tr} ${profileController.profileModel.value.firstName ?? ""},',
                    style: label.copyWith(color: Colors.black),
                  ),
                ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => profileController.isLoading.value ||
                  rewardsController.isLoading.value
              ? const LoaderWidget()
              : RefreshIndicator(
                  onRefresh: () async {
                    rewardsController.getRewardsPoints();
                    rewardsController.getRewardSummary("");
                    rewardsController.selectedCategory =
                        'business_category'.obs;
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Image.asset(Images.background),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 30.0),
                                      Text('reward_wallet'.tr, style: imgLabel),
                                      const SizedBox(height: 15.0),
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${rewardsController.rewardSummary.value.count ?? "0"}",
                                                  style: imgNum),
                                              const SizedBox(height: 10.0),
                                              Text('brands'.tr, style: imgDesc)
                                            ],
                                          ),
                                          const Spacer(),
                                          Image.asset('assets/line.png'),
                                          const Spacer(),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                  NumberFormat("#,##0").format(
                                                      int.parse(rewardsController
                                                                  .rewardSummary
                                                                  .value
                                                                  .totalPoints !=
                                                              null
                                                          ? "${double.parse(rewardsController.rewardSummary.value.totalPoints == null ? "0" : rewardsController.rewardSummary.value.totalPoints.toString()).round()}"
                                                          : "")),
                                                  style: imgNum),
                                              const SizedBox(height: 10.0),
                                              Text('total_rewards_points'.tr,
                                                  style: imgDesc),
                                              const SizedBox(height: 5.0),
                                              Text('1 ${"points".tr} = 1 Tsh',
                                                  style: imgDescRed)
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text('all_rewards'.tr, style: labelSm),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.06,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: const Color(0XFFD9D9D9),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('assets/search.png'),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            // width: size.width * 0.45,
                                            // height: 24,
                                            child: TextField(
                                              controller: rewardsController
                                                  .searchController,
                                              onChanged: (value) {
                                                rewardsController.searchData();
                                                setState(() {});
                                              },
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        bottom: 2),
                                                hintText: 'search_brand'.tr,
                                                border: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                              ),
                                              style: dialogTextSm.copyWith(
                                                  fontSize: 14.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Container(
                                  height: Get.height * 0.06,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color(0XFFD9D9D9))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: rewardsController
                                            .selectedCategory.value,
                                        onChanged: (newValue) {
                                          setState(() {
                                            rewardsController.selectedCategory
                                                .value = newValue ?? '';

                                            rewardsController.getRewardSummary(
                                                rewardsController
                                                            .selectedCategory
                                                            .value ==
                                                        "business_category"
                                                    ? ""
                                                    : "?category=${rewardsController.selectedCategory.value.tr}");
                                            rewardsController
                                                .getRewardsPoints()
                                                .then((value) {
                                              rewardsController.filterList(
                                                  rewardsController
                                                              .selectedCategory
                                                              .value ==
                                                          "business_category"
                                                      ? ""
                                                      : rewardsController
                                                          .selectedCategory
                                                          .value);
                                            });
                                          });
                                        },
                                        items: rewardsController
                                            .businessCategories
                                            .map((category) {
                                          return DropdownMenuItem<String>(
                                              value: category,
                                              child: Text(category.tr,
                                                  style: const TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  )));
                                        }).toList(),
                                        iconSize: 18,
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.black,
                                        ),
                                        // icon: Image.asset(
                                        //     'assets/dropdown_right.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: Get.height * 0.02),
                        rewardsController.rewardPoints.isEmpty
                            ? ListView(
                                shrinkWrap: true,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.4,
                                    width: Get.width,
                                  )
                                ],
                              )
                            : Expanded(
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  // shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount:
                                      rewardsController.rewardPoints.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                          color: Color(0XFFD9D9D9),
                                          thickness: 1),
                                  itemBuilder: (context, index) {
                                    TransactionModel data =
                                        rewardsController.rewardPoints[index];
                                    return GestureDetector(
                                      onTap: () {
                                        redeemBottomSheet(context, data);
                                      },
                                      child: Container(
                                        color: Colors.white,
                                        height: Get.height * 0.055,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.12,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(1),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xFFD9D9D9),
                                                          width: 1),
                                                    ),
                                                    child: data.image == null
                                                        ? CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            backgroundImage:
                                                                AssetImage(Images
                                                                    .profile),
                                                            radius: size.width *
                                                                0.12,
                                                          )
                                                        : CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            // backgroundImage:
                                                            //     AssetImage(Images.profile),

                                                            backgroundImage:
                                                                NetworkImage(
                                                                    data.image!),
                                                            radius: size.width *
                                                                0.12,
                                                          ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "${double.parse(data.points.toString()).round()}",
                                                        style: pointsBold),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                        data.merchantName ?? "",
                                                        style: pointsDesc),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: Get.width * 0.2,
                                              child: Visibility(
                                                // visible: data.days.isNotEmpty,
                                                visible: false,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        actionBottomSheet();
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 10,
                                                                vertical: 10),
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0XFFD9D9D9),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        22)),
                                                        child: Text('Action',
                                                            style: btnGreyText),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  redeemBottomSheet(BuildContext context, TransactionModel data) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.close(1);
                      },
                      child: Image.asset('assets/close.png'),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    width: Get.width * 0.15,
                    height: Get.height * 0.075,
                    child: Stack(
                      children: [
                        Align(
                          child: Container(
                            width: Get.width * 0.14,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFD9D9D9),
                                width: 2,
                              ),
                            ),
                            child: data.image == null
                                ? CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: AssetImage(Images.profile),
                                    radius: Get.width * 0.14,
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: NetworkImage(data.image!),
                                    radius: Get.width * 0.14,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 0,
                          child: Image.asset('assets/lc_check.png'),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(data.merchantName ?? "", style: pointsDesc),
                  const SizedBox(height: 15),
                  Text("${double.parse(data.points.toString()).round()}",
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF000000),
                      )),
                  const SizedBox(height: 5),
                  Text('total_rewards_points'.tr,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF808080),
                      ))
                ],
              ),
              SizedBox(height: Get.height * 0.05),
              SizedBox(
                width: Get.width * 0.8,
                height: Get.height * 0.07,
                child: TextButton(
                  onPressed: () {
                    Get.close(1);
                    rewardsController.redeemPoints(
                        data.merchantId!, data.points!);
                  },
                  style: btnGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/redeem.png'),
                      const SizedBox(width: 10),
                      Text(
                        'redeem'.tr,
                        style: label_sm,
                      ),
                      const SizedBox(width: 15)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              /* SizedBox(
                width: Get.width * 0.8,
                height: Get.height * 0.07,
                child: TextButton(
                  onPressed: () {
                    donateBottomSheet();
                  },
                  style: btnGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/donate.png'),
                      const SizedBox(width: 10),
                      Text('donate'.tr, style: label_sm2),
                      const SizedBox(width: 30)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5), */
              SizedBox(
                width: Get.width * 0.8,
                height: Get.height * 0.07,
                child: TextButton(
                  onPressed: () {
                    Get.close(1);
                    sharePoints(data.merchantId!, data);
                  },
                  style: btnGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/share.png'),
                      const SizedBox(width: 10),
                      Text('share_points'.tr, style: label_sm2),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.8,
                height: Get.height * 0.07,
                child: TextButton(
                  onPressed: () {
                    Get.close(1);
                    withdrawBottomSheet(data.merchantName ?? "");
                  },
                  child: Text(
                    'withdraw_from_program'.tr,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFCA1818),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  donateBottomSheet() {
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('charity'.tr, style: filterText),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: Get.width,
                        height: Get.height * 0.22,
                        child: Image.asset(
                          'assets/charity.png',
                          fit: BoxFit.fill,
                        )),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Text('Nuru ya Upendo Home of Homeless Kids',
                              style: charityLabel),
                          const SizedBox(height: 10),
                          Text(
                            'Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor. Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor.\n\nLorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor. Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor.\n\nLorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor. Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor.\n\n',
                            style: greyText2,
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            width: Get.width * 0.9,
                            height: Get.height * 0.07,
                            child: TextButton(
                              onPressed: () {
                                Get.close(1);
                                Get.bottomSheet(
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12))),
                                    Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12))),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                const Spacer(),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Image.asset(
                                                      'assets/close.png'),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    'assets/authentication.png'),
                                                const SizedBox(height: 10),
                                                Text('enter_pin'.tr,
                                                    style: pointsBold),
                                                const SizedBox(height: 15),
                                                SizedBox(
                                                  width: Get.width * 0.6,
                                                  child: Text(
                                                      'enter_pin_desc'.tr,
                                                      style: greyText2,
                                                      textAlign:
                                                          TextAlign.center),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                          SizedBox(
                                            width: Get.width * 0.9,
                                            height: Get.height * 0.07,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5.0),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xFFF5F5F5)),
                                                      color: const Color(
                                                          0xFFD9D9D9),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          child: Image.asset(
                                                              'assets/pin.png'),
                                                        ),
                                                        Expanded(
                                                          child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: <TextInputFormatter>[
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly,
                                                              LengthLimitingTextInputFormatter(
                                                                  4),
                                                            ],
                                                            obscureText: true,
                                                            decoration:
                                                                InputDecoration(
                                                              hintText:
                                                                  'pin'.tr,
                                                              hintStyle: const TextStyle(
                                                                  color: Color(
                                                                      0xFF808080)),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            style:
                                                                textFieldStyle,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Get.to(() => Submit());
                                                  },
                                                  style: btnGold2,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 13,
                                                        vertical: 8.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          'submit'.tr,
                                                          style: btnGoldText,
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Image.asset(
                                                            'assets/btn_arrow_right.png'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                              style: btnGrey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/donate_red.png'),
                                  const SizedBox(width: 10),
                                  Text('donate'.tr, style: label_sm2),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: InkWell(
                onTap: () {
                  Get.close(1);
                },
                child: Image.asset('assets/close.png'),
              ),
            ),
          ],
        ));
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
                            '2 ${"days_remaining".tr}',
                            style: desc,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: Get.width * 0.8,
                          child: TextButton(
                            onPressed: () {
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

  withdrawBottomSheet(String name) {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.close(1);
                  },
                  child: Image.asset('assets/close.png'),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: Get.width * 0.4,
                child: Text(
                    '${"withdraw_from".tr} $name ${"loyalty_program".tr}',
                    style: pointsBold,
                    textAlign: TextAlign.center),
              ),
              SizedBox(height: Get.height * 0.03),
              SizedBox(
                width: Get.width * 0.65,
                child: Text(
                    '${"loss_points".tr} $name ${"data_delete".tr} $name ${"as_customer".tr}',
                    style: greyText2,
                    textAlign: TextAlign.center),
              ),
              const SizedBox(height: 30),
              Text('do_cont'.tr, style: selectBtnBold),
              const SizedBox(height: 30),
              SizedBox(
                width: Get.width * 0.8,
                height: Get.height * 0.07,
                child: TextButton(
                  onPressed: () {
                    Get.close(1);
                  },
                  style: btnGrey,
                  child: Text('no'.tr, style: label_sm2),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: Get.width * 0.8,
                height: Get.height * 0.07,
                child: TextButton(
                  onPressed: () {
                    rewardsController.deleteAccount();
                  },
                  style: btnRed,
                  child: Text('yes'.tr, style: yesText),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
            ],
          ),
        ],
      ),
    );
  }

  sharePoints(String id, TransactionModel data) {
    rewardsController.numberController.clear();
    rewardsController.pointsController.clear();
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'share_points'.tr,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(height: Get.height * 0.05),
                  Column(
                    children: [
                      SizedBox(
                        width: Get.width * 0.15,
                        height: Get.height * 0.075,
                        child: Stack(
                          children: [
                            Align(
                              child: Container(
                                width: Get.width * 0.14,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFD9D9D9),
                                    width: 2,
                                  ),
                                ),
                                child: data.image == null
                                    ? CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            AssetImage(Images.profile),
                                        radius: Get.width * 0.14,
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            NetworkImage(data.image!),
                                        radius: Get.width * 0.14,
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              right: 0,
                              child: Image.asset('assets/lc_check.png'),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(data.merchantName ?? "", style: pointsDesc),
                      const SizedBox(height: 15),
                      Text("${double.parse(data.points.toString()).round()}",
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF000000),
                          )),
                      const SizedBox(height: 5),
                      Text('total_rewards_points'.tr,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 9,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF808080),
                          ))
                    ],
                  ),
                  SizedBox(height: Get.height * 0.05),
                  Container(
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: const Color(0XFFD9D9D9),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: rewardsController.pointsController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 2),
                          hintText: 'points'.tr,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: dialogTextSm.copyWith(fontSize: 14.0),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  Container(
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: const Color(0XFFD9D9D9),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: rewardsController.numberController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10)
                        ],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 2),
                          hintText: 'phone_number'.tr,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: dialogTextSm.copyWith(fontSize: 14.0),
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.05),
                  SizedBox(
                    width: Get.width * 0.8,
                    height: Get.height * 0.07,
                    child: TextButton(
                      onPressed: () {
                        if (rewardsController.numberController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "enter_number_msg".tr);
                        } else if (rewardsController
                                .numberController.text.length <
                            9) {
                          Fluttertoast.showToast(
                              msg: "enter_valid_number_msg".tr);
                        } else if (rewardsController
                            .pointsController.text.isEmpty) {
                          Fluttertoast.showToast(msg: "enter_point".tr);
                        } else {
                          Get.close(1);
                          rewardsController.sharePoints(id);
                        }
                      },
                      style: btnGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/share.png'),
                          const SizedBox(width: 10),
                          Text('share_points'.tr, style: label_sm2),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.05),
                ],
              ),
            ),
            Positioned(
              right: -10,
              top: 0,
              child: TextButton(
                onPressed: () {
                  Get.close(1);
                },
                child: Image.asset('assets/close.png'),
              ),
            )
          ],
        ));
  }
}
