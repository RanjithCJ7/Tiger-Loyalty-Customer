import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tl_customer/src/pages/pin_setup.dart';
import 'package:tl_customer/src/pages/signin.dart';
import 'styles.dart';

class Authentication extends StatelessWidget {
  // TextEditingController pinController = TextEditingController();

  final _pinFormatter = CustomTextInputFormatter();

  Future<void> otpLogin(String pin, BuildContext context) async {
    if (pin.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter OTP");
    } else {}

    try {
      final String apiUrl = "https://dummyjson.com/auth/login";

      Map<String, String> formData = {
        "pin": pin,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        body: formData,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        String token = data['token'];
        String pin = data['pin'];

        print('Token: $token');
        print('PIN : $pin');
        print('Login successfully');

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Verifying'),
              content: Text('Please wait'),
            );
          },
        );
      } else {
        final Map<String, dynamic> errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'];
        print('Login failed. Status code: ${response.statusCode}');
        print('Error Message: $errorMessage');

        // Show an error message to the user, e.g., using a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter otp'),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        margin: const EdgeInsets.only(bottom: 15.0),
                        child: Image.asset('assets/auth.png'),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Authentication',
                          style: label,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30.0),
                        child: Text(
                          'Enter OTP sent to your number',
                          style: desc,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 5.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFF5F5F5)),
                                color: const Color(0xFFD9D9D9),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Image.asset('assets/pin.png'),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      // controller: pinController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(4),
                                        _pinFormatter,
                                      ],
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: '* * * * * *',
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
                              // otpLogin(pinController.text, context);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PinSetup(),
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
                                      'Next',
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
                            'Haven’t received?',
                            style: forgotLabel,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PinSetup(),
                                ),
                              );
                            },
                            child: const Text('Resend'),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 25.0, bottom: 30.0),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Color(0xFF808080),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
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
                      Container(
                        margin: EdgeInsets.only(bottom: 50.0),
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          style: btnGrey,
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                                (route) => false);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign in',
                                  style: btnGreyText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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

class CustomTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    String text = newValue.text.replaceAll(RegExp(r'\D'), '');

    final StringBuffer newText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 3 == 0) {
        newText.write('-');
      }
      newText.write(text[i]);
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
