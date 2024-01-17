import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tl_customer/const/constant.dart';
import 'package:tl_customer/src/pages/styles.dart';

class ChangeLanguage {
  changeLanguage() {
    return Get.bottomSheet(
      StatefulBuilder(
          builder: (context, setState) => const ChangeLanguageSheet()),
      isDismissible: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22), topRight: Radius.circular(22))),
    );
  }
}

class LanguageModel {
  String name;
  bool isSelected;
  LanguageModel({required this.name, required this.isSelected});
}

class ChangeLanguageSheet extends StatefulWidget {
  const ChangeLanguageSheet({super.key});

  @override
  State<ChangeLanguageSheet> createState() => _ChangeLanguageSheetState();
}

class _ChangeLanguageSheetState extends State<ChangeLanguageSheet> {
  List<LanguageModel> languageList = [
    LanguageModel(name: "English", isSelected: true),
    LanguageModel(name: "Swahili", isSelected: false),
  ];

  @override
  void initState() {
    super.initState();
    getSharedPref().then((value) {
      setState(() {
        if (Params.language == "English") {
          languageList[0].isSelected = true;
          languageList[1].isSelected = false;
        } else {
          languageList[0].isSelected = false;
          languageList[1].isSelected = true;
        }
      });
    });
  }

  Future getSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Params.language = pref.getString("language") ?? "English";
    print("data ==> ${pref.getString("language")}");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          height: Get.height * 0.3,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'change_lang'.tr.replaceAll("?", ""),
                      style: alertTitle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          languageList[0].isSelected = true;
                          languageList[1].isSelected = false;
                          setLanguage("English");
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: languageList[0].isSelected == true
                                ? Colors.white
                                : const Color(0xFFD9D9D9),
                            border: Border.all(
                              width: 2,
                              color: const Color(0xFFD9D9D9),
                            ),
                            borderRadius: BorderRadius.circular(7)),
                        child: Row(
                          children: [
                            if (languageList[0].isSelected == true)
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Image.asset('assets/tick.png'),
                              ),
                            Text(
                              languageList[0].name,
                              style: languageList[0].isSelected == true
                                  ? const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    )
                                  : const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          languageList[1].isSelected = true;
                          languageList[0].isSelected = false;
                          setLanguage("Swahili");
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: languageList[1].isSelected == true
                                ? Colors.white
                                : const Color(0xFFD9D9D9),
                            border: Border.all(
                              width: 2,
                              color: const Color(0xFFD9D9D9),
                            ),
                            borderRadius: BorderRadius.circular(7)),
                        child: Row(
                          children: [
                            if (languageList[1].isSelected == true)
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Image.asset('assets/tick.png'),
                              ),
                            Text(
                              languageList[1].name,
                              style: languageList[1].isSelected == true
                                  ? const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    )
                                  : const TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 15,
          right: 10,
          child: InkWell(
            onTap: () {
              Get.close(1);
            },
            child: Container(
              margin: const EdgeInsets.only(
                left: 30.0,
              ),
              child: Image.asset('assets/close.png'),
            ),
          ),
        ),
      ],
    );
  }

  setLanguage(String language) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("language", language);
    Params.language = language;

    if (language == "English") {
      Get.updateLocale(const Locale('en'));
    } else {
      Get.updateLocale(const Locale('sw'));
    }
  }
}
