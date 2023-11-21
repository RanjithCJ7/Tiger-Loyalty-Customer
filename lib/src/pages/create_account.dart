import 'package:flutter/material.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/src/pages/change_profile.dart';
import 'styles.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ChangeProfile(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF000000),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(46),
              ),
              child: Image.asset(Images.loadingGIF),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Text(
                'Please wait...',
                style: label,
              ),
            ),
            Text(
              'Tiger is creating your account',
              style: desc,
            ),
          ],
        ),
      ),
    );
  }
}

