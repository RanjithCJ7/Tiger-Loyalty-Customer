import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/const/my_appbar.dart';
import 'package:tl_customer/src/pages/styles.dart';

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
  List<NotificaionModel> data = [
    NotificaionModel(
        title: "20% from your next bill @Pizza Hut",
        desc:
            "Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor. Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor.",
        time: "Now"),
    NotificaionModel(
        title: "2000 points received",
        desc: "You received 2000 rewards points from Nakumati. ",
        time: "1 day"),
    NotificaionModel(
        title: "2000 points received",
        desc: "You received 2000 rewards points from Nakumati. ",
        time: "2 weeks"),
    NotificaionModel(
        title: "Don’t lose your point",
        desc: "30 days remain before you lost your rewards at Pizza Hut.",
        time: "2 weeks"),
  ];

  var tabs = [
    {"name": "Rewards", "icon": Images.rewardsIcon},
    {"name": "Redeem", "icon": Images.redeemIcon},
    {"name": "Brands", "icon": Images.brandsIcon},
    {"name": "Profile", "icon": Images.profileIcon},
  ];
  String selectedTab = "Rewards";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: My_AppBar(context,
          title: Text('Notifications',
              style: label.copyWith(color: Colors.black))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: const Color(0xFFCA1818)),
                child: const Text(
                  "Clear all",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                separatorBuilder: (context, index) => Divider(
                  height: size.height * 0.01,
                  color: Colors.white,
                ),
                itemBuilder: (context, index) => Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        title: Text(
                          data[index].title,
                          style: const TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                        trailing: Text(
                          data[index].time,
                          style: const TextStyle(
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF808080),
                              fontSize: 12),
                        ),
                      ),
                      Text(
                        data[index].desc,
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
      bottomNavigationBar: Container(
        height: size.height * 0.09,
        color: const Color(0xFFD9D9D9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: tabs
              .map((e) => InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = e["name"]!;
                      });
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
    );
  }
}
