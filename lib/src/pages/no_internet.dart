import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'styles.dart';

class No_Internet extends StatefulWidget {
  @override
  _No_Internet_State createState() => _No_Internet_State();
}

class _No_Internet_State extends State<No_Internet> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (context) => No_In(),
      //   ),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/no_internet.png'),
            const SizedBox(height: 15),
            Text('FAILED', style: alertTitle),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.07,
              child: Text(
                'No internet connection',
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        height: MediaQuery.of(context).size.height - 125.0,
                        child: Dialog(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    const SizedBox(width: 40),
                                    Text(
                                      'Scan to',
                                      style: alertTitle,
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
                              const SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFF5F5F5)),
                                        color: Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          hintText: 'Amount',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF808080)),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(20),
                                        ),
                                        style: textFieldStyle,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Stack(
                                      children: [
                                        Image.asset('assets/qr_code.png'),
                                        Image.asset('assets/bg_qr_code.png'),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 25.0, bottom: 20.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              color: Color(0xFF808080),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                            child: Text("OR", style: orText),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              color: Color(0xFF808080),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFF5F5F5)),
                                        color: Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          hintText: 'Enter Lipa namba',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF808080)),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(20),
                                        ),
                                        style: textFieldStyle,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.12,
                                      child: TextButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                    125.0,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.all(5),
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
                                                    Stack(
                                                      children: [
                                                        Image.asset(
                                                            'assets/waikiki.png'),
                                                        Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          child: Image.asset(
                                                              'assets/lc_check.png'),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text('LC Waikiki',
                                                        style: pointsDesc),
                                                    const SizedBox(height: 20),
                                                    Text('Transaction value',
                                                        style: dialogTextSm),
                                                    const SizedBox(height: 15),
                                                    Text('150,000',
                                                        style: filterText),
                                                    const SizedBox(height: 30),
                                                    Text(
                                                        'What do you want to do?',
                                                        style: label_sm),
                                                    const SizedBox(height: 20),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.12,
                                                      child: TextButton(
                                                        style: btnGrey,
                                                        onPressed: () {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height -
                                                                    125.0,
                                                                alignment: Alignment
                                                                    .bottomCenter,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              5),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Spacer(),
                                                                          Text(
                                                                              'Make payment to',
                                                                              style: settingsTitle),
                                                                          const Spacer(),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                Image.asset('assets/close.png'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            30),
                                                                    Stack(
                                                                      children: [
                                                                        Image.asset(
                                                                            'assets/waikiki.png'),
                                                                        Positioned(
                                                                          bottom:
                                                                              0,
                                                                          right:
                                                                              0,
                                                                          child:
                                                                              Image.asset('assets/lc_check.png'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            15),
                                                                    Text(
                                                                        'LC Waikiki',
                                                                        style:
                                                                            pointsDesc),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                        '150,000',
                                                                        style:
                                                                            filterText),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                        'Amount to pay',
                                                                        style:
                                                                            dialogTextSm),
                                                                    const SizedBox(
                                                                        height:
                                                                            30),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.5,
                                                                      child: Text(
                                                                          'Enter phone number make payment',
                                                                          style:
                                                                              label_sm,
                                                                          textAlign:
                                                                              TextAlign.center),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            15),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.8,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border: Border.all(
                                                                            color:
                                                                                const Color(0xFFF5F5F5)),
                                                                        color: const Color(
                                                                            0xFFD9D9D9),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                const EdgeInsets.symmetric(horizontal: 15),
                                                                            child:
                                                                                Image.asset('assets/ion_keypad.png'),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                TextField(
                                                                              // controller: passwordController,
                                                                              keyboardType: TextInputType.number,
                                                                              inputFormatters: <TextInputFormatter>[
                                                                                FilteringTextInputFormatter.digitsOnly
                                                                              ],
                                                                              obscureText: true,
                                                                              decoration: const InputDecoration(
                                                                                hintText: 'Phone number',
                                                                                hintStyle: TextStyle(color: Color(0xFF808080)),
                                                                                border: InputBorder.none,
                                                                              ),
                                                                              style: textFieldStyle,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            15),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.8,
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.12,
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          showModalBottomSheet(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (BuildContext context) {
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
                                                                                          Text('Payment successful', style: settingsTitle),
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
                                                                                    Column(
                                                                                      children: [
                                                                                        const SizedBox(height: 30),
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
                                                                                        Text('15,000', style: filterText),
                                                                                        const SizedBox(height: 5),
                                                                                        Text('Bonus reward points', style: dialogTextSm),
                                                                                        const SizedBox(height: 20),
                                                                                        Center(
                                                                                          child: Row(
                                                                                            children: [
                                                                                              const Spacer(),
                                                                                              Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                                                children: [
                                                                                                  Text('150,000', style: numGreyText),
                                                                                                  Text('Transaction value', style: dialogTextSm),
                                                                                                ],
                                                                                              ),
                                                                                              const SizedBox(width: 15),
                                                                                              Image.asset('assets/line_col.png'),
                                                                                              const SizedBox(width: 20),
                                                                                              Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text('10%', style: numGreyText),
                                                                                                  Text('Reward', style: dialogTextSm)
                                                                                                ],
                                                                                              ),
                                                                                              const Spacer(),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(height: 50),
                                                                                        Container(
                                                                                          width: MediaQuery.of(context).size.width * 0.9,
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
                                                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                                children: <Widget>[
                                                                                                                  const Spacer(),
                                                                                                                  const SizedBox(width: 20),
                                                                                                                  Text('Review', style: alertTitle),
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
                                                                                                              width: MediaQuery.of(context).size.width * 0.8,
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
                                                                                                                Text('Please rate your experience', style: desc),
                                                                                                                const SizedBox(height: 15),
                                                                                                                Row(
                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                                                                                                Text('Have something to say? Please drop a comment', style: desc),
                                                                                                                const SizedBox(height: 10),
                                                                                                                Container(
                                                                                                                  width: MediaQuery.of(context).size.width * 0.8,
                                                                                                                  child: TextField(
                                                                                                                    maxLines: 2,
                                                                                                                    decoration: InputDecoration(
                                                                                                                      hintText: '',
                                                                                                                      border: OutlineInputBorder(
                                                                                                                        borderRadius: BorderRadius.circular(5.0),
                                                                                                                        borderSide: BorderSide(
                                                                                                                          color: Color(0xFFD9D9D9),
                                                                                                                        ),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                const SizedBox(height: 10),
                                                                                                                Container(
                                                                                                                  width: MediaQuery.of(context).size.width * 0.8,
                                                                                                                  height: MediaQuery.of(context).size.height * 0.07,
                                                                                                                  child: TextButton(
                                                                                                                    onPressed: () {
                                                                                                                      Navigator.of(context).pushReplacement(
                                                                                                                        MaterialPageRoute(
                                                                                                                          builder: (context) => No_Internet(),
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
                                                                                            child: Text('Review service', style: label_sm2),
                                                                                          ),
                                                                                        ),
                                                                                        const SizedBox(height: 50),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        style:
                                                                            btnGold2,
                                                                        child:
                                                                            Text(
                                                                          'Pay',
                                                                          style:
                                                                              btnGoldText2,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Text(
                                                          'Pay to collect reward points',
                                                          style: btnGreyText,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.12,
                                                      child: TextButton(
                                                        style: btnGrey,
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                          'Redeem your points',
                                                          style: btnGreyText,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 30)
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        style: btnGold2,
                                        child: Text(
                                          'Next',
                                          style: btnGoldText2,
                                        ),
                                      ),
                                    )
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
                child: Text('Connect', style: label_sm2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
