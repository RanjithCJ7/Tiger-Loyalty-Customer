import 'package:flutter/material.dart';
import 'styles.dart';

class Submit extends StatefulWidget {
  @override
  _SubmitState createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Failure(),
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
          children: [
            Image.asset('assets/success.png'),
            const SizedBox(height: 15),
            Text('DONE', style: alertTitle),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Text(
                'Your donation received with thanks.',
                style: greyText2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Failure extends StatefulWidget {
  @override
  _FailureState createState() => _FailureState();
}

class _FailureState extends State<Failure> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      // Add relevant actions upon failure if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/warning.png'),
            const SizedBox(height: 15),
            Text('FAILED', style: alertTitle),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Text(
                'Your transaction has failed',
                style: greyText2,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.07,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: btnGrey,
                child: Text('Try again', style: label_sm2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
