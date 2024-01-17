import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tl_customer/screens/profile/controller/profile_controller.dart';

import '../../../src/pages/styles.dart';

// ignore: must_be_immutable
class ChooseProfilePhoto extends StatelessWidget {
  ChooseProfilePhoto({super.key});

  ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: FileImage(File(profileController.path.path)),
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.darken)),
            ),
          ),
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundImage: FileImage(
                    File(profileController.path.path),
                  ),
                  radius: Get.height * 0.15,
                ),
              ),
              Stack(
                children: [
                  Positioned(
                    bottom: Get.height * 0.1,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                  profileController.path = XFile("null");
                                },
                                style: photoBtn,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 6),
                                  child: Text('cancel'.tr, style: photoText),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  profileController.uploadProfileImage();
                                  Get.back();
                                },
                                style: photoBtn,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 6),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Image.asset('assets/tick.png'),
                                      ),
                                      Text('choose'.tr, style: photoText),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
