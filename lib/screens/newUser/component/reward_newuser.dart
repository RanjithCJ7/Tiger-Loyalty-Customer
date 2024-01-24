import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/const/constant.dart';
import 'package:tl_customer/const/my_appbar.dart';
import 'package:tl_customer/initial_binding.dart';
import 'package:tl_customer/screens/newUser/controller/reward_newuser_controller.dart';
import 'package:tl_customer/screens/newUser/model/newuser_rewards_model.dart';
import 'package:tl_customer/screens/signup/component/register.dart';

import 'package:tl_customer/src/pages/styles.dart';
import 'package:tl_customer/widget/loader_widget.dart';

class RewardNewUser extends StatefulWidget {
  const RewardNewUser({super.key});

  @override
  State<RewardNewUser> createState() => _RewardNewUserState();
}

class _RewardNewUserState extends State<RewardNewUser> {
  RewardsNewUserController rewardsController =
      Get.find<RewardsNewUserController>();

  @override
  void initState() {
    rewardsController.getRewardsPoints();
    rewardsController.selectedCategory = 'business_category'.obs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            '${"hello".tr},',
            style: label.copyWith(color: Colors.black),
          ),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => rewardsController.isLoading.value
              ? const LoaderWidget()
              : Padding(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                "${rewardsController.allRewardPoints.value.count ?? "0"}",
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
                                                // rewardsController
                                                //     .allRewardPoints
                                                //     .value
                                                //     .totalPoints
                                                //     .toString(),
                                                NumberFormat("#,##0").format(
                                                    int.parse(rewardsController
                                                                .allRewardPoints
                                                                .value
                                                                .totalPoints !=
                                                            null
                                                        ? "${double.parse(rewardsController.allRewardPoints.value.totalPoints.toString()).round()}"
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

                                          // rewardsController.getRewardSummary(
                                          //     rewardsController.selectedCategory
                                          //                 .value ==
                                          //             "business_category"
                                          //         ? ""
                                          //         : "?category=${rewardsController.selectedCategory.value.tr}");
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
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          // shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: rewardsController
                              .rewardPoints.value.responseList!.length,
                          separatorBuilder: (context, index) => const Divider(
                              color: Color(0XFFD9D9D9), thickness: 1),
                          itemBuilder: (context, index) {
                            ResponseList data = rewardsController
                                .rewardPoints.value.responseList![index];
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                color: Colors.white,
                                height: Get.height * 0.055,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.12,
                                          child: Container(
                                            padding: const EdgeInsets.all(1),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFFD9D9D9),
                                                  width: 1),
                                            ),
                                            child: data.image == null
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage: AssetImage(
                                                        Images.profile),
                                                    radius: size.width * 0.12,
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    // backgroundImage:
                                                    //     AssetImage(Images.profile),

                                                    backgroundImage:
                                                        NetworkImage(
                                                            data.image!),
                                                    radius: size.width * 0.12,
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
                                            Text(data.merchantName ?? "",
                                                style: pointsDesc),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.2,
                                      child: GestureDetector(
                                          onTap: () {
                                            actionBottomSheet();
                                          },
                                          child: Container(
                                            // padding: const EdgeInsets.symmetric(
                                            //     horizontal: 10, vertical: 7),
                                            decoration: BoxDecoration(
                                                color: const Color(0XFFD9D9D9),
                                                borderRadius:
                                                    BorderRadius.circular(22)),
                                            child: Center(
                                              child: Text('action'.tr,
                                                  style: btnGreyText),
                                            ),
                                          )),
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
