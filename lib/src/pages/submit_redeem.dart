import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/src/pages/no_internet.dart';
import 'styles.dart';

class Submit_Redeem extends StatefulWidget {
  @override
  _Submit_Redeem_State createState() => _Submit_Redeem_State();
}

class _Submit_Redeem_State extends State<Submit_Redeem> {
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
          children: <Widget>[
            Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF000000),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(46),
              ),
              child: Image.asset(Images.loadingGIF),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0),
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

class Failure extends StatefulWidget {
  @override
  _FailureState createState() => _FailureState();
}

class _FailureState extends State<Failure> {
  double rating = 0.0;

  @override
  void initState() {
    super.initState();
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
                  submitReviewBottomSheet();
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

  void submitReviewBottomSheet() {
    rating = 0.0;
    Get.bottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12))), SingleChildScrollView(
      child: StatefulBuilder(builder: (context, setState) {
        return Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Review', style: filterText),
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.05),
                SizedBox(
                  width: Get.width * 0.2,
                  child: Stack(
                    children: [
                      Align(
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(0xFFD9D9D9), width: 2)),
                          child: Image.asset('assets/waikiki.png'),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image.asset('assets/lc_check.png'))
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Text('LC Waikiki', style: pointsDesc),
                const SizedBox(height: 30),
                Container(
                  width: Get.width * 0.8,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: Color(0XFFD9D9D9),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('rate_experience'.tr, style: desc),
                    const SizedBox(height: 15),
                    SmoothStarRating(
                      onRatingChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                      allowHalfRating: true,
                      starCount: 5,
                      rating: rating,
                      size: 30.0,
                      color: Colors.black,
                      borderColor: Colors.black,
                      spacing: 0.0,
                    ),
                    const SizedBox(height: 40),
                    Text('comment'.tr, style: desc),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: Get.width * 0.8,
                      child: TextField(
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Color(0xFFD9D9D9),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: Get.width * 0.8,
                      height: Get.height * 0.07,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => No_Internet(),
                            ),
                          );
                        },
                        style: btnGrey,
                        child: Text('post'.tr, style: label_sm2),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Column(
                          children: [
                            Image.asset('assets/share.png'),
                            const SizedBox(height: 10),
                            Text('share_receipt'.tr)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
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
            ),
          ],
        );
      }),
    ));
  }
}
