import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tl_customer/const/my_appbar.dart';
import 'package:tl_customer/src/pages/brands.dart';
import 'package:tl_customer/src/pages/profile.dart';
import 'package:tl_customer/src/pages/promo_board.dart';
import 'package:tl_customer/src/pages/rewards.dart';
import 'package:tl_customer/src/pages/submit.dart';
import 'package:tl_customer/const/Image.dart';
import 'styles.dart';

class Promo extends StatefulWidget {
  @override
  _Promo_State createState() => _Promo_State();
}

class Brand_Data {
  String image;
  String points;
  String name;

  Brand_Data({required this.image, required this.points, required this.name});
}

class Reward_Data {
  String min, max, percentage;
  Reward_Data({required this.min, required this.max, required this.percentage});
}

class Review_Data {
  String message;

  Review_Data({
    required this.message,
  });
}

class _Promo_State extends State<Promo> {
  List<String> city = [
    'Mlimani City',
    '',
    '',
    '',
  ];

  String selectedCity = 'Mlimani City';

  List<Brand_Data> brand_Data = [
    Brand_Data(image: 'assets/pizza.png', points: '50,000', name: 'Pizza Hut'),
    Brand_Data(image: 'assets/gsm.png', points: '135,000', name: 'GSM Home'),
    Brand_Data(image: 'assets/lc.png', points: '75,230', name: 'LC Waikiki'),
  ];
  List<Reward_Data> reward_Data = [
    Reward_Data(min: '10,000', max: '100,000', percentage: '1%'),
    Reward_Data(min: '100,001', max: '1,000,000', percentage: '2%'),
    Reward_Data(min: '1,000,001', max: '5,000,000', percentage: '3%'),
    Reward_Data(min: '5,000,001', max: '10,000,000', percentage: '4%'),
  ];
  List<Review_Data> review_Data = [
    Review_Data(
      message:
          'Lorem ipsum dolor sit amet consectetur. Urna pharetra congue et nibh nulla libero massa.',
    ),
    Review_Data(
      message:
          'Lorem ipsum dolor sit amet consectetur. Urna pharetra congue et nibh nulla libero massa.',
    ),
    Review_Data(
      message:
          'Lorem ipsum dolor sit amet consectetur. Urna pharetra congue et nibh nulla libero massa. Mauris rhoncus quam porttitor massa Lorem ipsum dolor sit',
    ),
    Review_Data(
      message:
          'Lorem ipsum dolor sit amet consectetur. Urna pharetra congue et nibh nulla libero massa.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: My_AppBar(
        context,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Brands', style: label.copyWith(color: Colors.black))
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
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
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color(0XFFD9D9D9))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/search.png'),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: size.width * 0.3,
                                          height: 24,
                                          child: TextField(
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 11),
                                              hintText: 'Search brand',
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                            style: dialogTextSm,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: const Color(0XFFD9D9D9))),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Promo_Board(),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: size.width * 0.2,
                                    child: Row(
                                      children: [
                                        Text('Categories',
                                            style: selectBtnBold),
                                        SizedBox(width: 10),
                                        Image.asset('assets/dropdown_right.png')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                      const SizedBox(height: 30.0),
                      ListView.separated(
                        padding: const EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        itemCount: brand_Data.length,
                        separatorBuilder: (context, index) => const Divider(
                            color: Color(0XFFD9D9D9), thickness: 1),
                        itemBuilder: (context, index) {
                          var data = brand_Data[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            height: MediaQuery.of(context).size.height * 0.055,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          child: SizedBox(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.all(5),
                                                    child: Row(
                                                      children: <Widget>[
                                                        const Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Image.asset(
                                                              'assets/close.png'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Image.asset(
                                                          'assets/brand_pizza.png'),
                                                      Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: Image.asset(
                                                            'assets/lc_check.png'),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Text('Pizza Hut',
                                                      style: transBold),
                                                  const SizedBox(height: 5),
                                                  Text('Fast Food',
                                                      style: dialogTextSm),
                                                  const SizedBox(height: 20),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Container(
                                                                        margin:
                                                                            EdgeInsets.all(5),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            const Spacer(),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                              child: Image.asset('assets/close.png'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          Text(
                                                                              'Reviews',
                                                                              style: settingsTitle),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Image.asset('assets/star_active.png'),
                                                                              const SizedBox(width: 10),
                                                                              Image.asset('assets/star_active.png'),
                                                                              const SizedBox(width: 10),
                                                                              Image.asset('assets/star_active.png'),
                                                                              const SizedBox(width: 10),
                                                                              Image.asset('assets/star_active.png'),
                                                                              const SizedBox(width: 10),
                                                                              Image.asset('assets/star_inactive.png')
                                                                            ],
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 15),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.9,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border(
                                                                                bottom: BorderSide(
                                                                                  width: 1.0,
                                                                                  color: Color(0XFFD9D9D9),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 15),
                                                                          Container(
                                                                            // width:
                                                                            //     MediaQuery.of(context).size.width * 0.9,
                                                                            child:
                                                                                ListView.separated(
                                                                              itemCount: review_Data.length,
                                                                              shrinkWrap: true,
                                                                              separatorBuilder: (context, index) => Divider(
                                                                                color: Colors.transparent,
                                                                              ),
                                                                              itemBuilder: (context, index) {
                                                                                return ListTile(
                                                                                  title: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                      color: Color(0xFFD9D9D9),
                                                                                    ),
                                                                                    child: ListTile(
                                                                                      leading: Image.asset(Images.profile),
                                                                                      title: Text(
                                                                                        review_Data[index].message,
                                                                                        style: transDesc,
                                                                                        // textAlign: TextAlign.justify,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 30),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                    'assets/star_active.png'),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Image.asset(
                                                                    'assets/star_active.png'),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Image.asset(
                                                                    'assets/star_active.png'),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Image.asset(
                                                                    'assets/star_active.png'),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Image.asset(
                                                                    'assets/star_inactive.png')
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            IntrinsicHeight(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                          '4.0',
                                                                          style:
                                                                              rewardText),
                                                                      const SizedBox(
                                                                          width:
                                                                              5),
                                                                      Image.asset(
                                                                          'assets/star_gold.png'),
                                                                    ],
                                                                  ),
                                                                  const VerticalDivider(
                                                                    color: Colors
                                                                        .black,
                                                                    thickness:
                                                                        1,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Image.asset(
                                                                          'assets/mail_gold.png'),
                                                                      const SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                          '213',
                                                                          style:
                                                                              rewardText),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                        'assets/b_thumbs.png'),
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            'TZS 10,000',
                                                                            style:
                                                                                selectBtnBold),
                                                                        Text(
                                                                            'Minimum spending',
                                                                            style:
                                                                                minText),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Image.asset(
                                                                        'assets/b_insta.png'),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Image.asset(
                                                                        'assets/b_facebook.png'),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Image.asset(
                                                                        'assets/b_x.png')
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.8,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  bottom:
                                                                      BorderSide(
                                                                    width: 1.0,
                                                                    color: Color(
                                                                        0XFFD9D9D9),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          0xFFF5F5F5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      border: Border.all(
                                                                          color:
                                                                              const Color(0XFFD9D9D9))),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            10.0),
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              size.width * 0.25,
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.05,
                                                                          child:
                                                                              DropdownButtonHideUnderline(
                                                                            child:
                                                                                DropdownButton<String>(
                                                                              value: selectedCity,
                                                                              onChanged: (newValue) {
                                                                                setState(() {
                                                                                  selectedCity = newValue ?? '';
                                                                                });
                                                                              },
                                                                              items: city.map((city) {
                                                                                return DropdownMenuItem<String>(value: city, child: Text(city, style: selectBtnBold));
                                                                              }).toList(),
                                                                              icon: Image.asset('assets/drop_down.png'),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          0xFFF5F5F5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      border: Border.all(
                                                                          color:
                                                                              const Color(0XFFD9D9D9))),
                                                                  child:
                                                                      SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        0.23,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.05,
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        showModalBottomSheet(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return Container(
                                                                              child: SizedBox(
                                                                                child: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Container(
                                                                                        margin: EdgeInsets.all(5),
                                                                                        child: Row(
                                                                                          children: <Widget>[
                                                                                            const Spacer(),
                                                                                            Text('Rewards table', style: alertTitle),
                                                                                            const Spacer(),
                                                                                            InkWell(
                                                                                              onTap: () {
                                                                                                Navigator.of(context).pop();
                                                                                              },
                                                                                              child: Image.asset('assets/close.png'),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(height: 20),
                                                                                      Column(
                                                                                        children: [
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.9,
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  SizedBox(
                                                                                                      width: MediaQuery.of(context).size.width * 0.3,
                                                                                                      child: const Text(
                                                                                                        "Min",
                                                                                                        style: TextStyle(
                                                                                                          fontFamily: 'Inter',
                                                                                                          fontSize: 16,
                                                                                                          fontWeight: FontWeight.w800,
                                                                                                        ),
                                                                                                      )),
                                                                                                  SizedBox(
                                                                                                      width: MediaQuery.of(context).size.width * 0.3,
                                                                                                      child: const Text(
                                                                                                        "Max",
                                                                                                        style: TextStyle(
                                                                                                          fontFamily: 'Inter',
                                                                                                          fontSize: 16,
                                                                                                          fontWeight: FontWeight.w800,
                                                                                                        ),
                                                                                                      )),
                                                                                                  SizedBox(
                                                                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                                                                      child: const Text(
                                                                                                        "Reward%",
                                                                                                        style: TextStyle(
                                                                                                          fontFamily: 'Inter',
                                                                                                          fontSize: 16,
                                                                                                          fontWeight: FontWeight.w800,
                                                                                                        ),
                                                                                                      ))
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.9,
                                                                                            child: ListView.builder(
                                                                                              padding: EdgeInsets.zero,
                                                                                              shrinkWrap: true,
                                                                                              itemCount: reward_Data.length,
                                                                                              itemBuilder: (context, index) {
                                                                                                return Container(
                                                                                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                                                                                  height: MediaQuery.of(context).size.height * 0.055,
                                                                                                  decoration: BoxDecoration(color: index.isEven ? const Color(0XFFD9D9D9) : Colors.white),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                    children: [
                                                                                                      SizedBox(width: MediaQuery.of(context).size.width * 0.3, child: Text(reward_Data[index].min)),
                                                                                                      SizedBox(width: MediaQuery.of(context).size.width * 0.3, child: Text(reward_Data[index].max)),
                                                                                                      SizedBox(width: MediaQuery.of(context).size.width * 0.15, child: Text(reward_Data[index].percentage)),
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
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child: Text(
                                                                          'Rewards',
                                                                          style:
                                                                              selectBtnBold),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          0xFFF5F5F5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      border: Border.all(
                                                                          color:
                                                                              const Color(0XFFD9D9D9))),
                                                                  child:
                                                                      SizedBox(
                                                                    width:
                                                                        size.width *
                                                                            0.2,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.05,
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        showModalBottomSheet(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return Container(
                                                                              child: SizedBox(
                                                                                // height: MediaQuery.of(context).size.height - 125.0,
                                                                                child: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Container(
                                                                                        margin: EdgeInsets.all(5),
                                                                                        child: Row(
                                                                                          children: <Widget>[
                                                                                            const Spacer(),
                                                                                            Text('MENU', style: alertTitle),
                                                                                            const Spacer(),
                                                                                            InkWell(
                                                                                              onTap: () {
                                                                                                Navigator.of(context).pop();
                                                                                              },
                                                                                              child: Image.asset('assets/close.png'),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                      const SizedBox(height: 20),
                                                                                      Image.asset('assets/b_menu.png'),
                                                                                      const SizedBox(height: 30),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                      child: Text(
                                                                          'Menu',
                                                                          style:
                                                                              selectBtnBold),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 20),
                                                            Text(
                                                                'Lorem ipsum dolor sit amet consectetur. Urna pharetra congue et nibh nulla libero massa. Mauris rhoncus quam porttitor massa Lorem ipsum dolor sit amet consectetur. Urna pharetra congue et nibh nulla libero massa. Mauris rhoncus quam porttitor massa Lorem ipsum dolor sit amet consectetur. Urna pharetra congue et nibh nulla libero massa. Mauris rhoncus quam porttitor massa',
                                                                style:
                                                                    dialogTextSm,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify),
                                                            const SizedBox(
                                                                height: 20),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.8,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border(
                                                                  bottom:
                                                                      BorderSide(
                                                                    width: 1.0,
                                                                    color: Color(
                                                                        0XFFD9D9D9),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 20),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          0xFFF5F5F5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      border: Border.all(
                                                                          color:
                                                                              const Color(0XFFD9D9D9))),
                                                                  child:
                                                                      SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        0.23,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.05,
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {},
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Image.asset(
                                                                              'assets/b_direction.png'),
                                                                          const SizedBox(
                                                                              width: 5),
                                                                          Text(
                                                                              'Direction',
                                                                              style: selectBtnBold)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 15),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          0xFFF5F5F5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      border: Border.all(
                                                                          color:
                                                                              const Color(0XFFD9D9D9))),
                                                                  child:
                                                                      SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        0.25,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.05,
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {},
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Image.asset(
                                                                              'assets/b_whatsapp.png'),
                                                                          const SizedBox(
                                                                              width: 5),
                                                                          Text(
                                                                              'Whatsapp',
                                                                              style: selectBtnBold)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 15),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: const Color(
                                                                          0xFFF5F5F5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      border: Border.all(
                                                                          color:
                                                                              const Color(0XFFD9D9D9))),
                                                                  child:
                                                                      SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        0.22,
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.05,
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {},
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Image.asset(
                                                                              'assets/b_call.png'),
                                                                          const SizedBox(
                                                                              width: 5),
                                                                          Text(
                                                                              'Call',
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
                                                  const SizedBox(height: 30),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.1,
                                        child: Image.asset(data.image),
                                      ),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        width: size.width * 0.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(data.points,
                                                style: pointsBold),
                                            const SizedBox(height: 5),
                                            Text(data.name, style: pointsDesc),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/rewards.png',
                            color: Color.fromRGBO(0, 0, 0, 0.3)),
                        SizedBox(height: 5),
                        Text('Rewards',
                            style: footerText.copyWith(
                                color: Color.fromRGBO(0, 0, 0, 0.3))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/redeem.png',
                            color: Color.fromRGBO(0, 0, 0, 0.3)),
                        SizedBox(height: 5),
                        Text('Redeem',
                            style: footerText.copyWith(
                                color: Color.fromRGBO(0, 0, 0, 0.3))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Brands(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/brands.png'),
                          SizedBox(height: 5),
                          Text('Brands', style: footerText),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/profile.png',
                            color: Color.fromRGBO(0, 0, 0, 0.3)),
                        SizedBox(height: 5),
                        Text('Profile',
                            style: footerText.copyWith(
                                color: Color.fromRGBO(0, 0, 0, 0.3))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
