import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:tl_customer/const/my_appbar.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/screens/newUser/controller/brands_newuser.dart';
import 'package:tl_customer/screens/newUser/model/newuser_rewards_model.dart';
import 'package:tl_customer/screens/promo/model/merchant_details_model.dart';

import 'package:tl_customer/widget/loader_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../src/pages/styles.dart';

class BrandsNewUser extends StatefulWidget {
  @override
  _BrandsNewUser_State createState() => _BrandsNewUser_State();
}

class _BrandsNewUser_State extends State<BrandsNewUser> {
  BrandsNewUserController promoController = Get.find<BrandsNewUserController>();

  int? pages = 0;
  int? currentPage = 0;
  String errorMessage = '';

  @override
  void initState() {
    promoController.getRewardsPoints();
    promoController.selectedFilter =
        FilterModel(image: Images.allFilter, name: 'All');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text('Brands', style: label.copyWith(color: Colors.black)),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => promoController.isLoading.value
              ? const LoaderWidget()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: Get.height * 0.06,
                                    alignment: Alignment.center,
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
                                              controller: promoController
                                                  .searchController,
                                              onChanged: (value) {
                                                promoController.searchData();
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
                                PopupMenuButton<FilterModel>(
                                  constraints: BoxConstraints(
                                      maxWidth: Get.width, minWidth: Get.width),
                                  itemBuilder: (context) {
                                    List<PopupMenuItem<FilterModel>> menuItems =
                                        [
                                      PopupMenuItem<FilterModel>(
                                        value: FilterModel(
                                            image: Images.allFilter,
                                            name: 'All'),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: Get.width * 0.05,
                                                      child: Image.asset(
                                                        Images.allFilter,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    const Text("All"),
                                                  ],
                                                ),
                                                promoController.selectedFilter
                                                            .name ==
                                                        "All"
                                                    ? const Icon(
                                                        Icons.check,
                                                        color:
                                                            Color(0xFF279C4F),
                                                      )
                                                    : const Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        color: Colors.black,
                                                        size: 18,
                                                      )
                                              ],
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 15),
                                              height: 2,
                                              width: Get.width,
                                              color: const Color(0xFFD9D9D9),
                                            )
                                          ],
                                        ),
                                      ),
                                      ...promoController.filterData
                                          .map((FilterModel filter) {
                                        return PopupMenuItem<FilterModel>(
                                          value: filter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: Get.width * 0.05,
                                                    child: Image.asset(
                                                      filter.image,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(filter.name),
                                                ],
                                              ),
                                              promoController.selectedFilter
                                                          .name ==
                                                      filter.name
                                                  ? const Icon(
                                                      Icons.check,
                                                      color: Color(0xFF279C4F),
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      color: Colors.black,
                                                      size: 18,
                                                    )
                                            ],
                                          ),
                                        );
                                      }),
                                    ];

                                    return menuItems;
                                  },
                                  onSelected: (value) {
                                    setState(() {
                                      promoController.selectedFilter = value;
                                      promoController.filterList(
                                          promoController.selectedFilter.name ==
                                                  "All"
                                              ? ""
                                              : promoController
                                                  .selectedFilter.name);
                                    });
                                  },
                                  offset: const Offset(0, 50),
                                  color: Colors.white,
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: Get.height * 0.055,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: const Color(0XFFD9D9D9))),
                                    child: Row(
                                      children: [
                                        Text(
                                            promoController
                                                        .selectedFilter.name ==
                                                    "All"
                                                ? 'categories'.tr
                                                : promoController
                                                    .selectedFilter.name,
                                            style: selectBtnBold),
                                        const SizedBox(width: 10),
                                        Image.asset('assets/dropdown_right.png')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                        const SizedBox(height: 20.0),
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: promoController
                              .rewardPoints.value.responseList!.length,
                          separatorBuilder: (context, index) => const Divider(
                              color: Color(0XFFD9D9D9), thickness: 1),
                          itemBuilder: (context, index) {
                            ResponseList data = promoController
                                .rewardPoints.value.responseList![index];
                            return GestureDetector(
                              onTap: () {
                                promoController
                                    .getMerchantDetails(data.merchantId!);
                                brandBottomSheet(data.merchantId!);
                              },
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
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void brandBottomSheet(String merchantId) {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        isScrollControlled: true,
        backgroundColor: Colors.white,
        SizedBox(
          child: Obx(() => promoController.isLoadingMerchant.value
              ? SizedBox(
                  height: Get.height * 0.7,
                  child: const LoaderWidget(),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
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
                      SizedBox(
                        width: Get.width * 0.2,
                        height: Get.height * 0.1,
                        child: Stack(
                          children: [
                            Align(
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: const Color(0xFFCFAF4E),
                                        width: 2)),
                                child: promoController
                                            .merchantDeatails.value.image ==
                                        null
                                    ? CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage:
                                            AssetImage(Images.profile),
                                        radius: Get.width * 0.15,
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                            promoController
                                                .merchantDeatails.value.image!),
                                        radius: Get.width * 0.15,
                                      ),
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 5,
                                child: Image.asset('assets/lc_check.png'))
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                          promoController.merchantDeatails.value.merchantName ??
                              "",
                          style: transBold),
                      const SizedBox(height: 5),
                      Text(
                          promoController.merchantDeatails.value
                                  .userInformation!.category ??
                              "",
                          style: dialogTextSm),
                      const SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              if (promoController
                                  .merchantDeatails.value.reviews!.isNotEmpty) {
                                Get.close(1);
                                rewiewBottomSheet();
                              }
                            },
                            child: Column(
                              children: [
                                SmoothStarRating(
                                  onRatingChanged: (rating) {
                                    if (promoController.merchantDeatails.value
                                        .reviews!.isNotEmpty) {
                                      Get.close(1);
                                      rewiewBottomSheet();
                                    }
                                  },
                                  allowHalfRating: false,
                                  starCount: 5,
                                  rating: promoController.merchantDeatails.value
                                          .averageRating ??
                                      0,
                                  size: 30.0,
                                  color: Colors.black,
                                  borderColor: Colors.black,
                                  spacing: 0.0,
                                ),
                                const SizedBox(height: 10),
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              "${double.parse(promoController.merchantDeatails.value.averageRating.toString()).round()}",
                                              style: rewardText),
                                          const SizedBox(width: 5),
                                          Image.asset('assets/star_gold.png'),
                                        ],
                                      ),
                                      const VerticalDivider(
                                        color: Colors.black,
                                        thickness: 1,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset('assets/mail_gold.png'),
                                          const SizedBox(width: 5),
                                          Text(
                                              "${promoController.merchantDeatails.value.reviews!.length}",
                                              style: rewardText),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: Get.width * 0.9,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset('assets/b_thumbs.png'),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'TZS ${promoController.merchantDeatails.value.userInformation!.rewardTable == null ? 0 : double.parse(promoController.merchantDeatails.value.userInformation!.rewardTable![0].min.toString()).round()}',
                                                style: selectBtnBold),
                                            Text('min_spend'.tr,
                                                style: minText),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            launchSocialMedia(promoController
                                                    .merchantDeatails
                                                    .value
                                                    .userInformation!
                                                    .instagram ??
                                                "null");
                                          },
                                          child: Image.asset(
                                            'assets/b_insta.png',
                                          ),
                                        ),
                                        SizedBox(width: Get.width * 0.02),
                                        GestureDetector(
                                          onTap: () async {
                                            launchSocialMedia(promoController
                                                    .merchantDeatails
                                                    .value
                                                    .userInformation!
                                                    .facebook ??
                                                "null");
                                          },
                                          child: Image.asset(
                                              'assets/b_facebook.png'),
                                        ),
                                        SizedBox(width: Get.width * 0.02),
                                        GestureDetector(
                                          onTap: () async {
                                            launchSocialMedia(promoController
                                                    .merchantDeatails
                                                    .value
                                                    .userInformation!
                                                    .twitter ??
                                                "null");
                                          },
                                          child: Image.asset('assets/b_x.png'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: const Color(0XFFD9D9D9),
                                  height: Get.height * 0.04,
                                  thickness: 1,
                                ),
                                Row(
                                  children: [
                                    if (promoController
                                            .selectedLocations.value.location !=
                                        null) ...[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color:
                                                    const Color(0XFFD9D9D9))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width: Get.width * 0.25,
                                                  height: Get.height * 0.05,
                                                  child: PopupMenuButton<
                                                      Locations>(
                                                    itemBuilder: (context) {
                                                      return promoController
                                                          .merchantDeatails
                                                          .value
                                                          .locations!
                                                          .map(
                                                              (e) =>
                                                                  PopupMenuItem(
                                                                    value: e,
                                                                    child: Text(
                                                                        e.location!),
                                                                  ))
                                                          .toList();
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.18,
                                                          child: Text(
                                                            promoController
                                                                    .selectedLocations
                                                                    .value
                                                                    .location ??
                                                                "",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                selectBtnBold,
                                                          ),
                                                        ),
                                                        const Icon(Icons
                                                            .arrow_drop_down),
                                                      ],
                                                    ),
                                                    onSelected: (value) {
                                                      setState(() {
                                                        promoController
                                                            .selectedLocations
                                                            .value = value;
                                                      });
                                                    },
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10)
                                    ],
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF5F5F5),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: const Color(0XFFD9D9D9))),
                                      child: SizedBox(
                                        width: Get.width * 0.23,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextButton(
                                          onPressed: () {
                                            if (promoController
                                                    .merchantDeatails
                                                    .value
                                                    .userInformation!
                                                    .rewardTable !=
                                                null) {
                                              Get.close(1);
                                              rewardBottomSheet();
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "data_not_found".tr);
                                            }
                                          },
                                          child: Text('rewards'.tr,
                                              style: selectBtnBold),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF5F5F5),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: const Color(0XFFD9D9D9))),
                                      child: SizedBox(
                                        width: Get.width * 0.2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextButton(
                                          onPressed: () {
                                            if (promoController.merchantDeatails
                                                    .value.menu !=
                                                null) {
                                              Get.close(1);
                                              menuBottomSheet();
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "data_not_found".tr);
                                            }
                                          },
                                          child: Text('menu'.tr,
                                              style: selectBtnBold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                    promoController.merchantDeatails.value
                                            .description ??
                                        "",
                                    style: dialogTextSm,
                                    textAlign: TextAlign.justify),
                                Divider(
                                  color: const Color(0XFFD9D9D9),
                                  height: Get.height * 0.04,
                                  thickness: 1,
                                ),
                                Row(
                                  children: [
                                    if (promoController
                                            .selectedLocations.value.location !=
                                        null) ...[
                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFF5F5F5),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color:
                                                    const Color(0XFFD9D9D9))),
                                        child: SizedBox(
                                          width: Get.width * 0.23,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: TextButton(
                                            onPressed: () {
                                              launchGoogleMaps(promoController
                                                  .selectedLocations
                                                  .value
                                                  .location);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/b_direction.png'),
                                                const SizedBox(width: 5),
                                                Text('direction'.tr,
                                                    style: selectBtnBold)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15)
                                    ],
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF5F5F5),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: const Color(0XFFD9D9D9))),
                                      child: SizedBox(
                                        width: Get.width * 0.25,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextButton(
                                          onPressed: () {
                                            openWhatsApp(promoController
                                                    .merchantDeatails
                                                    .value
                                                    .userInformation!
                                                    .whatsapp ??
                                                "null");
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/b_whatsapp.png'),
                                              const SizedBox(width: 5),
                                              Text('whatsapp'.tr,
                                                  style: selectBtnBold)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF5F5F5),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: const Color(0XFFD9D9D9))),
                                      child: SizedBox(
                                        width: Get.width * 0.22,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: TextButton(
                                          onPressed: () {
                                            makePhoneCall(promoController
                                                    .merchantDeatails
                                                    .value
                                                    .userInformation!
                                                    .phoneNumber ??
                                                "null");
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset('assets/b_call.png'),
                                              const SizedBox(width: 5),
                                              Text('call'.tr,
                                                  style: selectBtnBold)
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: Get.height * 0.03),
                    ],
                  ),
                )),
        ));
  }

  void rewiewBottomSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      SizedBox(
        height: Get.height * 0.7,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Text('reviews'.tr, style: settingsTitle),
                  const SizedBox(height: 10),
                  SmoothStarRating(
                    allowHalfRating: true,
                    starCount: 5,
                    rating:
                        promoController.merchantDeatails.value.averageRating ??
                            0,
                    size: 25.0,
                    color: Colors.black,
                    borderColor: Colors.black,
                    spacing: 0.0,
                  ),
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(
                      color: Color(0XFFD9D9D9),
                      height: 2,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: promoController
                          .merchantDeatails.value.reviews!.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.transparent,
                        height: 8,
                      ),
                      itemBuilder: (context, index) {
                        var data = promoController
                            .merchantDeatails.value.reviews![index];
                        return Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFD9D9D9),
                          ),
                          child: ListTile(
                            leading: Image.asset(Images.profile),
                            title: Text(
                              data.comment ?? "",
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF808080),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
            )
          ],
        ),
      ),
    );
  }

  void rewardBottomSheet() {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        isScrollControlled: true,
        backgroundColor: Colors.white,
        Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('reward_table'.tr, style: alertTitle),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    SizedBox(
                      width: Get.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: Get.width * 0.3,
                                child: Text(
                                  "min".tr,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )),
                            SizedBox(
                                width: Get.width * 0.3,
                                child: Text(
                                  "max".tr,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                )),
                            SizedBox(
                                width: Get.width * 0.2,
                                child: Text(
                                  "reward_per".tr,
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.9,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        shrinkWrap: true,
                        itemCount: promoController.merchantDeatails.value
                            .userInformation!.rewardTable!.length,
                        itemBuilder: (context, index) {
                          var data = promoController.merchantDeatails.value
                              .userInformation!.rewardTable![index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            height: Get.height * 0.055,
                            decoration: BoxDecoration(
                                color: index.isEven
                                    ? const Color(0XFFD9D9D9)
                                    : Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: Get.width * 0.3,
                                    child: Text(NumberFormat("#,##0").format(
                                        double.parse(data.min.toString())
                                            .round()))),
                                SizedBox(
                                    width: Get.width * 0.3,
                                    child: Text(NumberFormat("#,##0").format(
                                        double.parse(data.max.toString())
                                            .round()))),
                                SizedBox(
                                    width: Get.width * 0.15,
                                    child: Text("${data.reward}%")),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: InkWell(
                onTap: () {
                  Get.close(1);
                },
                child: Image.asset('assets/close.png'),
              ),
            )
          ],
        ));
  }

  void menuBottomSheet() {
    Get.bottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        isScrollControlled: true,
        backgroundColor: Colors.white,
        FutureBuilder(
            future: createFileOfPdfUrl(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? SizedBox(
                      height: Get.height * 0.6, child: const LoaderWidget())
                  : StatefulBuilder(builder: (context, setState) {
                      return Stack(
                        children: [
                          SizedBox(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('menu1'.tr, style: alertTitle),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        color: const Color(0xFFD9D9D9)
                                            .withOpacity(0.5),
                                        blurRadius: 10,
                                        spreadRadius: 10,
                                        offset: const Offset(10, 10))
                                  ]),
                                  height: Get.height * 0.7,
                                  child: PDFView(
                                    filePath: snapshot.data!.path,
                                    enableSwipe: true,
                                    swipeHorizontal: true,
                                    autoSpacing: false,
                                    pageFling: true,
                                    onRender: (totalPages) {
                                      setState(() {
                                        pages = totalPages;
                                      });
                                    },
                                    onError: (error) {
                                      setState(() {
                                        errorMessage = error.toString();
                                      });
                                    },
                                    onPageError: (page, error) {
                                      setState(() {
                                        errorMessage =
                                            '$page: ${error.toString()}';
                                      });
                                      print('$page: ${error.toString()}');
                                    },
                                    onLinkHandler: (String? uri) {
                                      print('goto uri: $uri');
                                    },
                                    onPageChanged: (int? page, int? total) {
                                      setState(() {
                                        currentPage = page;
                                      });
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: indicators(pages, currentPage),
                                ),
                                SizedBox(height: Get.height * 0.02),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: InkWell(
                              onTap: () {
                                Get.close(1);
                              },
                              child: Image.asset('assets/close.png'),
                            ),
                          )
                        ],
                      );
                    });
            }));
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();

    try {
      final url = promoController.merchantDeatails.value.menu!;
      final filename = url.substring(url.lastIndexOf("/") + 1);

      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();

      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: currentIndex == index ? const Color(0xFF0E2ED4) : Colors.grey,
          shape: BoxShape.circle,
        ),
      );
    });
  }

  launchSocialMedia(param0) async {
    if (param0 != "null") {
      if (await canLaunchUrl(Uri.parse(param0))) {
        await launchUrl(Uri.parse(param0));
      } else {
        Fluttertoast.showToast(msg: "invalid_link".tr);
      }
    } else {
      Fluttertoast.showToast(msg: "data_not_found".tr);
    }
  }

  openWhatsApp(param0) async {
    if (param0 != "null") {
      final url = "whatsapp://send?phone=+255$param0";

      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        Fluttertoast.showToast(msg: "invalid_link".tr);
      }
    } else {
      Fluttertoast.showToast(msg: "data_not_found".tr);
    }
  }

  makePhoneCall(param0) async {
    if (param0 != "null") {
      if (await canLaunchUrl(Uri.parse("tel:$param0"))) {
        await launchUrl(Uri.parse("tel:$param0"),
            mode: LaunchMode.externalApplication);
      } else {
        Fluttertoast.showToast(msg: "invalid_link".tr);
      }
    } else {
      Fluttertoast.showToast(msg: "data_not_found".tr);
    }
  }

  launchGoogleMaps(param0) async {
    if (param0 != "null") {
      String formattedAddress = param0.replaceAll(' ', '+');

      String googleMapsUrl =
          "https://www.google.com/maps/search/?api=1&query=$formattedAddress";

      if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
        await launchUrl(Uri.parse(googleMapsUrl));
      } else {
        throw 'Could not launch $googleMapsUrl';
      }
    } else {
      Fluttertoast.showToast(msg: "data_not_found".tr);
    }
  }
}
