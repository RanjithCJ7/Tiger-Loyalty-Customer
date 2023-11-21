import 'package:flutter/material.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/src/pages/brands.dart';
import 'package:tl_customer/src/pages/deals.dart';
import 'package:tl_customer/src/pages/home_newuser.dart';
import 'package:tl_customer/src/pages/promo.dart';

import 'src/pages/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: ''),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home_NewUser()),
        // MaterialPageRoute(builder: (context) => Promo()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Image.asset(
          Images.loadingGIF,
          height: 50,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splash.png'),
            const SizedBox(height: 15.0),
            Text(
              'One App, Multiple Wallets',
              style: splashText,
            ),
          ],
        )
        /* Stack(
          children: [
            // if (isLoading)
            // Image.asset(
            //   "assets/loading.gif",
            //   height: 125.0,
            //   width: 125.0,
            // ),
            // if (!isLoading)
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 175.0),
                  child: Column(
                    children: [
                      Image.asset('assets/splash.png'),
                      SizedBox(height: 15.0),
                      Text(
                        'Reward for Growth',
                        style: splashText,
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  Images.loadingGIF,
                  height: 50,
                ),
              ],
            ),
          ],
        ) */
        ,
      ),
    );
  }
}
