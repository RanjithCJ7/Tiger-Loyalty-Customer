import 'package:flutter/material.dart';
import 'package:tl_customer/src/pages/signin.dart';
import 'styles.dart';

class Home_NewUser extends StatefulWidget {
  @override
  _Home_NewUserState createState() => _Home_NewUserState();
}

class _Home_NewUserState extends State<Home_NewUser> {
  bool points = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.01,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40.0),
                    GestureDetector(
                      onPanUpdate: (details) {
                        if (details.delta.dx > 0) {
                          setState(() {
                            points = true;
                          });
                        }
                        if (details.delta.dx < 0) {
                          setState(() {
                            points = false;
                          });
                        }
                      },
                      child: points
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('assets/welcome_bg.png'),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/welcome.png',
                                      ),
                                      const SizedBox(height: 30.0),
                                      Text(
                                        'Welcome to Tiger Loyalty',
                                        style: welcomeTitle,
                                      ),
                                      const SizedBox(height: 20.0),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Text(
                                          'Lorem ipsum dolor sit amet consectetur. Eget vitae aenean risus aliquet elit turpis quam. Ut tellus tincidunt hendrerit venenatis. Sed integer semper felis felis eros lobortis risus.',
                                          style: welcomeDesc,
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('assets/welcome_bg.png'),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/welcome.png',
                                      ),
                                      const SizedBox(height: 30.0),
                                      Text(
                                        'Welcome to Tiger Loyalty 2',
                                        style: welcomeTitle,
                                      ),
                                      const SizedBox(height: 20.0),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Text(
                                          'Lorem ipsum dolor sit amet consectetur. Eget vitae aenean risus aliquet elit turpis quam. Ut tellus tincidunt hendrerit venenatis. Sed integer semper felis felis eros lobortis risus.',
                                          style: welcomeDesc,
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ),
                    const SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Text('Get started', style: startText),
                          const SizedBox(height: 20.0),
                          SizedBox(
                            width: size.width,
                            height: 44,
                            child: TextButton(
                              style: btnGrey,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SignIn(),
                                  ),
                                );
                              },
                              child: Text('Sign in or register',
                                  style: startBtnText),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            width: size.width,
                            height: 44,
                            child: TextButton(
                              style: btnGrey,
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SignIn(),
                                  ),
                                );
                              },
                              child: Text('Make payment to collect rewards',
                                  style: startBtnText),
                            ),
                          ),
                        ],
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
  }
}
