import 'package:flutter/material.dart';
import 'styles.dart';

class Review extends StatefulWidget {
  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, top: 30),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset('assets/chevron_left.png'),
                      ),
                      Spacer()
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            Text('Reviews', style: label),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child:
                                        Image.asset('assets/star_active.png')),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child:
                                        Image.asset('assets/star_active.png')),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child:
                                        Image.asset('assets/star_active.png')),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child:
                                        Image.asset('assets/star_active.png')),
                                Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Image.asset(
                                        'assets/star_inactive.png')),
                              ],
                            ),
                            SizedBox(height: 30),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: Image.asset('assets/review.png'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Lorem ipsum dolor sit amet consectetur. Urna pharetra congue et nibh nulla libero massa.',
                                          style: transDesc,
                                          textAlign: TextAlign.justify,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: Image.asset('assets/review.png'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Lorem ipsum dolor sit amet consectetur. Urna pharetra congue et nibh nulla libero massa.',
                                          style: transDesc,
                                          textAlign: TextAlign.justify,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: Image.asset('assets/review.png'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Lorem ipsum dolor sit amet consectetur. Urna pharetra congue et nibh nulla libero massa. Mauris rhoncus quam porttitor massa Lorem ipsum dolor sit',
                                          style: transDesc,
                                          textAlign: TextAlign.justify,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 15),
                                        child: Image.asset('assets/review.png'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Lorem ipsum dolor sit amet consectetur. Urna pharetra congue et nibh nulla libero massa.',
                                          style: transDesc,
                                          textAlign: TextAlign.justify,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
