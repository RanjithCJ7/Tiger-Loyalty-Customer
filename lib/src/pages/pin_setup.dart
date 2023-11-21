import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tl_customer/src/pages/create_account.dart';
import 'styles.dart';

class PinSetup extends StatelessWidget {
  final _oldPinFormatter = CustomTextInputFormatter();
  final _newPinFormatter = CustomTextInputFormatter();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(size.width * 0.1),
              child: Column(
                children: <Widget>[
                  Column(
                    children: [
                      Image.asset('assets/pin_setup.png'),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'PIN setup',
                        style: label,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        'Protect your deals and rewards',
                        style: desc,
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.54,
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
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4),
                                      _oldPinFormatter,
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
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Container(
                            width: size.width * 0.54,
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
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4),
                                      _newPinFormatter,
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
                          SizedBox(width: size.width * 0.01),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CreateAccount(),
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
