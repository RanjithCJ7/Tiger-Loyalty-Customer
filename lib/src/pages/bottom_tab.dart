import 'package:flutter/material.dart';
import 'package:tl_customer/src/pages/brands.dart';
// import 'package:tl_customer/src/pages/notification.dart';
import 'package:tl_customer/src/pages/profile.dart';
import 'package:tl_customer/src/pages/rewards.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int index = 0;
  // var screen = [Home(), GiveReward(), Customers(), Profile()];
  var screen = [Rewards(), Brands(), Profile()];

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
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Rewards',
            icon: Image.asset('assets/rewards.png',
                color: index == 0 ? Colors.black : const Color(0xFFB0B0B0)),
          ),
          BottomNavigationBarItem(
            label: 'Redeem',
            icon: Image.asset('assets/redeem.png',
                color: index == 1 ? Colors.black : const Color(0xFFB0B0B0)),
          ),
          BottomNavigationBarItem(
              label: 'Brands',
              icon: Image.asset('assets/brands.png',
                  color: index == 2 ? Colors.black : const Color(0xFFB0B0B0))),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Image.asset('assets/profile.png',
                  color: index == 3 ? Colors.black : const Color(0xFFB0B0B0))),
        ],
      ),
      body: screen[index],
    );
  }
}
