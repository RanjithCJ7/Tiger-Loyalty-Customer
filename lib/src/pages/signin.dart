import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tl_customer/src/pages/register.dart';
import 'styles.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isValidPhoneNumber(String phone) {
    final phonePattern = r'^\d{10}$';
    final regExp = RegExp(phonePattern);
    return regExp.hasMatch(phone);
  }

  Future<void> login(String phone, String password) async {
    if (!isValidPhoneNumber(phone)) {
      Fluttertoast.showToast(msg: "Please check the entered Phone number");
    } else if (password.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter PIN");
      return;
    } else {}
  }

  void showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Image.asset('assets/signin.png'),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Sign in',
                          style: label,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          'You need an account to proceed',
                          style: desc,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFF5F5F5)),
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Image.asset('assets/ion_keypad.png'),
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                hintText: 'Phone number',
                                hintStyle: TextStyle(color: Color(0xFF808080)),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                              style: textFieldStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFF5F5F5)),
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Image.asset('assets/pin.png'),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'PIN',
                                    hintStyle:
                                        TextStyle(color: Color(0xFF808080)),
                                    border: InputBorder.none,
                                  ),
                                  style: textFieldStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // login(phoneController.text, passwordController.text);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ),
                          );
                        },
                        style: btnGold,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(
                                  'Sign in',
                                  style: btnGoldText,
                                ),
                              ),
                              Image.asset('assets/btn_arrow_right.png'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Forgot PIN?',
                        style: forgotLabel,
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Reset PIN'),
                                content: const Text(
                                    'Are you sure you want to reset your PIN?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Reset',
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Color(0xFF808080),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("OR", style: orText),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Color(0xFF808080),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: 50,
                    child: TextButton(
                      style: btnGrey,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                      child: Text('Register', style: btnGreyText),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.075,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Badili lugha?',
                          style: smText,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'KSW',
                            style: boldText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
