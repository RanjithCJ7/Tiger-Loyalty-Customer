import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'styles.dart';

class Submit extends StatefulWidget {
  @override
  _SubmitState createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
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
            Text('done'.tr, style: alertTitle),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width * 0.4,
              height: Get.height * 0.07,
              child: Text(
                'donation_received'.tr,
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

    Future.delayed(const Duration(seconds: 2), () {
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
            Text('failed'.tr, style: alertTitle),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width * 0.8,
              height: Get.height * 0.07,
              child: Text(
                'transaction_failed'.tr,
                style: greyText2,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: Get.width * 0.8,
              height: Get.height * 0.07,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: btnGrey,
                child: Text('try_again'.tr, style: label_sm2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
