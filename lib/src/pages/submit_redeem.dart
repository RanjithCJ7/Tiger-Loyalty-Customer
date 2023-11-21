import 'package:flutter/material.dart';
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
                'You transaction has failed',
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
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height - 125.0,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      const Spacer(),
                                      const SizedBox(width: 20),
                                      Text('Review', style: filterText),
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
                                const SizedBox(height: 50.0),
                                Stack(
                                  children: [
                                    Image.asset('assets/waikiki.png'),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Image.asset('assets/lc_check.png'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text('LC Waikiki', style: pointsDesc),
                                const SizedBox(height: 30),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
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
                                    Text('Please rate your experience',
                                        style: desc),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/star_inactive.png'),
                                        const SizedBox(width: 5),
                                        Image.asset('assets/star_inactive.png'),
                                        const SizedBox(width: 5),
                                        Image.asset('assets/star_inactive.png'),
                                        const SizedBox(width: 5),
                                        Image.asset('assets/star_inactive.png'),
                                        const SizedBox(width: 5),
                                        Image.asset('assets/star_inactive.png')
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Text(
                                        'Have something to say? Please drop a comment',
                                        style: desc),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: TextField(
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                          hintText: '',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                              color: Color(0xFFD9D9D9),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  No_Internet(),
                                            ),
                                          );
                                        },
                                        style: btnGrey,
                                        child: Text('Post', style: label_sm2),
                                      ),
                                    ),
                                    const SizedBox(height: 40),
                                    Container(
                                      child: Center(
                                        child: TextButton(
                                          onPressed: () {},
                                          child: Column(
                                            children: [
                                              Image.asset('assets/share.png'),
                                              const SizedBox(height: 10),
                                              Text('Share receipt')
                                            ],
                                          ),
                                        ),
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
