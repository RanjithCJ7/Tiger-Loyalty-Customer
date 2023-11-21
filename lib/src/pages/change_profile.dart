import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tl_customer/src/pages/unregistered.dart';
import 'styles.dart';

class ChangeProfile extends StatefulWidget {
  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  XFile? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    ImagePicker picker = ImagePicker();
    XFile? selectedImage = await picker.pickImage(
      source: source,
      imageQuality: 100,
      maxWidth: 720,
      maxHeight: 1280,
    );

    if (selectedImage != null) {
      await cropImage(selectedImage);
    }
  }

  Future<void> cropImage(XFile? file) async {
    if (file != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              _pickImage(ImageSource.gallery);
            },
            child: Image.asset('assets/tigersuit.png'),
          ),
          const SizedBox(height: 50),
          Text('Congratulations', style: label),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You are officially a', style: desc),
              const SizedBox(width: 5),
              Text('Tigerian,', style: descGold),
            ],
          ),
          Text('the deal hunter.', style: desc),
          const SizedBox(height: 15),
          Text('Happy hunting!', style: label_sm),
          const SizedBox(height: 30),
          Row(
            children: [
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Unregistered(),
                    ),
                  );
                },
                style: btnGrey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sign in ',
                        style: btnGoldText,
                      ),
                      const SizedBox(width: 10),
                      Image.asset('assets/btn_arrow_right.png'),
                    ],
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
          const SizedBox(height: 70),
          Text(
            'Change profile picture',
            style: desc,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: btnGrey,
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Image.asset('assets/choose_photo.png'),
                      const SizedBox(width: 10),
                      Text('Choose Photos', style: desc2),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              TextButton(
                style: btnGrey,
                onPressed: () {
                  _pickImage(ImageSource.camera);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      Image.asset('assets/take_photo.png'),
                      const SizedBox(width: 10),
                      Text('Take Photo', style: desc2),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (_imageFile != null)
            Image.file(
              File(_imageFile!.path),
              width: 200,
              height: 200,
            ),
        ],
      ),
    );
  }
}
