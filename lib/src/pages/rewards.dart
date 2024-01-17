import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tl_customer/const/Image.dart';
import 'package:tl_customer/const/my_appbar.dart';
import 'package:tl_customer/src/pages/brands.dart';
import 'package:tl_customer/screens/profile/component/profile.dart';
import 'package:tl_customer/screens/promo/component/promo.dart';
import 'package:tl_customer/src/pages/redeem.dart';
import 'package:tl_customer/src/pages/submit.dart';
import 'package:tl_customer/src/pages/submit_redeem.dart';
import 'styles.dart';

class Rewards extends StatefulWidget {
  @override
  _Rewards_State createState() => _Rewards_State();
}

class Reward_Data {
  String image;
  String points;
  String name;
  String days;

  Reward_Data(
      {required this.image,
      required this.points,
      required this.name,
      required this.days});
}

class _Rewards_State extends State<Rewards> {
  List<String> categories = [
    'Categories',
    'Shopping',
    'Supermarket',
    'Restaurant',
    'Spa',
    'Salon',
  ];

  String selectedCategory = 'Categories';

  List<Reward_Data> reward_Data = [
    Reward_Data(
        image: 'assets/pizza.png',
        points: '50,000',
        name: 'Pizza Hut',
        days: '30 days'),
    Reward_Data(
        image: 'assets/gsm.png', points: '135,000', name: 'GSM Home', days: ''),
    Reward_Data(
        image: 'assets/lc.png', points: '75,230', name: 'LC Waikiki', days: ''),
  ];

  void _navigateToScreen(BuildContext context, String name, Reward_Data data) {
    switch (name) {
      case 'Pizza Hut':
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height - 125.0,
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: [
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
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(data.image),
                        const SizedBox(height: 10),
                        Text(data.name, style: pointsDesc),
                        const SizedBox(height: 15),
                        Text(data.points, style: pointsBold),
                        const SizedBox(height: 5),
                        Text('Total reward points', style: rewardSm)
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height:
                                  MediaQuery.of(context).size.height - 125.0,
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Text('Redeem points',
                                            style: settingsTitle),
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child:
                                              Image.asset('assets/close.png'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const SizedBox(height: 30),
                                      Stack(
                                        children: [
                                          Image.asset('assets/waikiki.png'),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Image.asset(
                                                'assets/lc_check.png'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Text('LC Waikiki', style: pointsDesc),
                                      const SizedBox(height: 15),
                                      Text('135,000', style: filterText),
                                      const SizedBox(height: 15),
                                      Text('New transaction value',
                                          style: dialogTextSm),
                                      const SizedBox(height: 15),
                                      Center(
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text('150,000',
                                                    style: numGreyText),
                                                Text('Transaction value',
                                                    style: dialogTextSm),
                                              ],
                                            ),
                                            const SizedBox(width: 15),
                                            Image.asset('assets/line_col.png'),
                                            const SizedBox(width: 20),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text('15,000',
                                                    style: numGreyText),
                                                Text('Your points',
                                                    style: dialogTextSm)
                                              ],
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 50),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        child: TextButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        child: Row(
                                                          children: [
                                                            const Spacer(),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Image.asset(
                                                                  'assets/close.png'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Image.asset(
                                                              'assets/authentication.png'),
                                                          const SizedBox(
                                                              height: 15),
                                                          Text('Enter PIN',
                                                              style:
                                                                  charityLabel),
                                                          const SizedBox(
                                                              height: 30.0),
                                                          Text(
                                                              'To redeem 15,000 points at LC Waikiki',
                                                              style: desc),
                                                          const SizedBox(
                                                              height: 50),
                                                          Row(
                                                            children: [
                                                              const SizedBox(
                                                                  width: 25),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: const Color(
                                                                          0xFFF5F5F5)),
                                                                  color: const Color(
                                                                      0xFFD9D9D9),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              15),
                                                                      child: Image
                                                                          .asset(
                                                                              'assets/pin.png'),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          TextField(
                                                                        // controller:
                                                                        //     signupController.pin2Controller,
                                                                        keyboardType:
                                                                            TextInputType.number,
                                                                        inputFormatters: <TextInputFormatter>[
                                                                          FilteringTextInputFormatter
                                                                              .digitsOnly,
                                                                        ],
                                                                        obscureText:
                                                                            true,
                                                                        decoration:
                                                                            const InputDecoration(
                                                                          hintText:
                                                                              'PIN',
                                                                          hintStyle:
                                                                              TextStyle(color: Color(0xFF808080)),
                                                                          border:
                                                                              InputBorder.none,
                                                                        ),
                                                                        style:
                                                                            textFieldStyle,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 5),
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              Submit_Redeem(),
                                                                    ),
                                                                  );
                                                                },
                                                                style: btnGold2,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          13,
                                                                      vertical:
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'Submit',
                                                                        style:
                                                                            btnGoldText,
                                                                      ),
                                                                      const SizedBox(
                                                                          width:
                                                                              10),
                                                                      Image.asset(
                                                                          'assets/btn_arrow_right.png'),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 50.0),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          style: btnGold,
                                          child: Text('Redeem & Pay',
                                              style: label_sm),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      style: btnGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/redeem.png'),
                          const SizedBox(width: 10),
                          Text(
                            'Redeem',
                            style: label_sm,
                          ),
                          const SizedBox(width: 15)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          const Spacer(),
                                          Text('Charity', style: filterText),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child:
                                                Image.asset('assets/close.png'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Center(
                                        child:
                                            Image.asset('assets/charity.png')),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Column(
                                        children: [
                                          Text(
                                              'Nuru ya Upendo Home of Homeless Kids',
                                              style: charityLabel),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor. Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor.\n\nLorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor. Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor.\n\nLorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor. Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor.\n\n',
                                            style: greyText2,
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(height: 15),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            child: TextButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height -
                                                              125.0,
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Row(
                                                              children: [
                                                                const Spacer(),
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: Image
                                                                      .asset(
                                                                          'assets/close.png'),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Column(
                                                              children: [
                                                                Image.asset(
                                                                    'assets/authentication.png'),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    'Enter PIN',
                                                                    style:
                                                                        pointsBold),
                                                                const SizedBox(
                                                                    height: 15),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.6,
                                                                  child: Text(
                                                                      'Enter your PIN to donate to  Nuru ya Upendo Home of Homeless Kids',
                                                                      style:
                                                                          greyText2,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 30),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.9,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.07,
                                                            child: Row(
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            5.0),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              const Color(0xFFF5F5F5)),
                                                                      color: const Color(
                                                                          0xFFD9D9D9),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                    ),
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 15),
                                                                          child:
                                                                              Image.asset('assets/pin.png'),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              TextField(
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            inputFormatters: <TextInputFormatter>[
                                                                              FilteringTextInputFormatter.digitsOnly,
                                                                              LengthLimitingTextInputFormatter(4),
                                                                            ],
                                                                            obscureText:
                                                                                true,
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              hintText: 'PIN',
                                                                              hintStyle: TextStyle(color: Color(0xFF808080)),
                                                                              border: InputBorder.none,
                                                                            ),
                                                                            style:
                                                                                textFieldStyle,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Submit(),
                                                                      ),
                                                                    );
                                                                  },
                                                                  style:
                                                                      btnGold2,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            13,
                                                                        vertical:
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          'Submit',
                                                                          style:
                                                                              btnGoldText,
                                                                        ),
                                                                        const SizedBox(
                                                                            width:
                                                                                10),
                                                                        Image.asset(
                                                                            'assets/btn_arrow_right.png'),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 100.0),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              style: btnGrey,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      'assets/donate_red.png'),
                                                  const SizedBox(width: 10),
                                                  Text('Donate',
                                                      style: label_sm2),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 30),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: btnGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/donate.png'),
                          const SizedBox(width: 10),
                          Text('Donate', style: label_sm2),
                          const SizedBox(width: 30)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: btnGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/share.png'),
                          const SizedBox(width: 10),
                          Text('Share points', style: label_sm2),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height:
                                  MediaQuery.of(context).size.height - 125.0,
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child:
                                              Image.asset('assets/close.png'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          child: Text(
                                              'Withdraw from Pizza Hut Loyalty Program',
                                              style: pointsBold,
                                              textAlign: TextAlign.center),
                                        ),
                                        const SizedBox(height: 30),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: Text(
                                              'You will lose all the rewards collected from Pizza Hut and your personal data will be deleted from Pizza Hut as customer',
                                              style: greyText2,
                                              textAlign: TextAlign.center),
                                        ),
                                        const SizedBox(height: 30),
                                        Text('Do you want to continue',
                                            style: selectBtnBold),
                                        const SizedBox(height: 30),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: btnGrey,
                                            child: Text('No', style: label_sm2),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: btnRed,
                                            child: Text('Yes', style: yesText),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        'Withdraw from program',
                        style: modalTextRed,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
        break;
      case 'GSM Home':
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height - 125.0,
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          data.name,
                          style: alertTitle,
                          textAlign: TextAlign.center,
                        ),
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
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          data.name,
                          style: dialogTextSm,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.all(30.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: btnGold2,
                      child: Text(
                        'Proceed',
                        style: btnGoldText2,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
        break;
      case 'LC Waikiki':
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height - 125.0,
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          data.name,
                          style: alertTitle,
                          textAlign: TextAlign.center,
                        ),
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
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          data.name,
                          style: dialogTextSm,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    margin: EdgeInsets.all(30.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: btnGold2,
                      child: Text(
                        'Proceed',
                        style: btnGoldText2,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: My_AppBar(
        context,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text('${"hello".tr} Juma,',
              style: label.copyWith(color: Colors.black)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              /* Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.4,
                                child: Image.asset('assets/rectangle_1.png'),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Image.asset('assets/rectangle_2.png'),
                              ), */
                              SizedBox(
                                  height: Get.height * 0.18,
                                  width: Get.width,
                                  child: Image.asset(
                                    Images.background,
                                    fit: BoxFit.fill,
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: Get.height * 0.025),
                                    Text('Reward wallet', style: imgLabel),
                                    SizedBox(height: Get.height * 0.015),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('4', style: imgNum),
                                            const SizedBox(height: 10.0),
                                            Text('Brands', style: imgDesc)
                                          ],
                                        ),
                                        const Spacer(),
                                        Image.asset('assets/line.png'),
                                        const Spacer(),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text('265,120', style: imgNum),
                                            const SizedBox(height: 10.0),
                                            Text('Total rewards points',
                                                style: imgDesc),
                                            const SizedBox(height: 5.0),
                                            Text('1 Point = 1 Tsh',
                                                style: imgDescRed)
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text('All rewards', style: labelSm),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color(0XFFD9D9D9))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/search.png'),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: size.width * 0.45,
                                          height: 24,
                                          child: TextField(
                                            decoration: const InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 11),
                                              hintText: 'Search brand',
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                            ),
                                            style: dialogTextSm,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF5F5F5),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: const Color(0XFFD9D9D9))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.2,
                                        height: 24,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: selectedCategory,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedCategory =
                                                    newValue ?? '';
                                              });
                                            },
                                            items: categories.map((category) {
                                              return DropdownMenuItem<String>(
                                                  value: category,
                                                  child: Text(category,
                                                      style: selectBtnBold));
                                            }).toList(),
                                            icon: Image.asset(
                                                'assets/dropdown_right.png'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                      const SizedBox(height: 30.0),
                      ListView.separated(
                        // padding: const EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        itemCount: reward_Data.length,
                        separatorBuilder: (context, index) => const Divider(
                            color: Color(0XFFD9D9D9), thickness: 1),
                        itemBuilder: (context, index) {
                          var data = reward_Data[index];
                          return Container(
                            // padding: const EdgeInsets.symmetric(horizontal: 5),
                            height: Get.height * 0.055,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _navigateToScreen(context, 'Pizza Hut',
                                        reward_Data[index]);
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.1,
                                        child: Image.asset(data.image),
                                      ),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        width: size.width * 0.55,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(data.points,
                                                style: pointsBold),
                                            const SizedBox(height: 5),
                                            Text(data.name, style: pointsDesc),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.15,
                                  child: Visibility(
                                    visible: data.days.isNotEmpty,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(data.days, style: dayText),
                                        const SizedBox(height: 5),
                                        Text('Remain', style: remainText)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            /* Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/rewards.png'),
                        SizedBox(height: 5),
                        Text('Rewards', style: footerText),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/redeem.png',
                            color: Color.fromRGBO(0, 0, 0, 0.3)),
                        SizedBox(height: 5),
                        Text('Redeem',
                            style: footerText.copyWith(
                                color: Color.fromRGBO(0, 0, 0, 0.3))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Promo(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/brands.png',
                              color: Color.fromRGBO(0, 0, 0, 0.3)),
                          SizedBox(height: 5),
                          Text('Brands',
                              style: footerText.copyWith(
                                  color: Color.fromRGBO(0, 0, 0, 0.3))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Profile(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/profile.png',
                              color: Color.fromRGBO(0, 0, 0, 0.3)),
                          SizedBox(height: 5),
                          Text('Profile',
                              style: footerText.copyWith(
                                  color: Color.fromRGBO(0, 0, 0, 0.3))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
           */
          ],
        ),
      ),
    );
  }
}
