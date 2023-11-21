import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tl_customer/src/pages/styles.dart';

class ImageUploadHelper {
  final ImagePicker _picker = ImagePicker();
  CroppedFile? _croppedFile;

  ///Image Picker
  Future<void> showImagePicker(
      BuildContext context, Function(XFile?) onImagePicked) async {
    // chooseOption(context);
  }

  ///----- Crop Image Picker
  Future<void> showCropImagePicker(BuildContext context, bool isCircleProfile,
      Function(XFile?) onImagePicked) async {
    chooseOption(context, isCircleProfile, onImagePicked);
  }

  ///----- Crop Image using aspectRatio
  Future<void> cropImage(XFile? file, Function(XFile? p1) onImagePicked,
      bool isCircleProfile) async {
    if (file != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatio: isCircleProfile
            ? const CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
            : const CropAspectRatio(ratioX: 2.0, ratioY: 1.0),
        cropStyle: isCircleProfile ? CropStyle.circle : CropStyle.rectangle,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'cropper',
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              showCropGrid: false,
              hideBottomControls: true,
              lockAspectRatio: true),
        ],
      );
      if (croppedFile != null) {
        _croppedFile = croppedFile;
        if (Platform.isIOS) {
          File rotatedImage =
              await FlutterExifRotation.rotateImage(path: _croppedFile!.path);
          XFile filepath = XFile(rotatedImage.path);
          onImagePicked(filepath);
        } else {
          XFile filepath = XFile(_croppedFile!.path);
          onImagePicked(filepath);
        }
      }
    }
  }

  Future<XFile?> imgFromGallery() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 720,
      maxHeight: 1280,
    );
    File f = File(image!.path);

    var fileSizeLimit = 3072;
    var s = f.lengthSync();
    var fileSizeInKB = s / 1024;

    if (fileSizeInKB > fileSizeLimit) {
      Fluttertoast.showToast(msg: "Please select image size less than 3MB");
    } else {
      return image;
    }
  }

  Future<XFile?> imgFromCamera() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
      maxWidth: 720,
      maxHeight: 1280,
    );

    File f = File(image!.path);

    var fileSizeLimit = 3072;
    var s = f.lengthSync();
    var fileSizeInKB = s / 1024;

    if (fileSizeInKB > fileSizeLimit) {
      Fluttertoast.showToast(msg: "Please select image size less than 3MB");
    } else {
      // if (image != null) {
      //   // Rotate the image to fix the wrong rotation coming from ImagePicker
      //   File rotatedImage =
      //       await FlutterExifRotation.rotateImage(path: image.path);
      //   print("return rotated");
      //   return XFile(rotatedImage.path); //Return the file
      // }
      // print("normal");
      return image;
    }
  }

  chooseOption(BuildContext context, bool isCircleProfile,
      Function(XFile?) onImagePicked) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset('assets/close.png'),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Change Profile Picture',
                    style: changeLabel,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        XFile? file = await imgFromGallery();
                        cropImage(file, onImagePicked, isCircleProfile);
                      },
                      style: btnGrey,
                      child: Text(
                        'Choose Photo',
                        style: btnGreyText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: TextButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        XFile? file = await imgFromCamera();
                        cropImage(file, onImagePicked, isCircleProfile);
                      },
                      style: btnGrey,
                      child: Text(
                        'Take picture',
                        style: btnGreyText,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1)
          ],
        );
      },
    );
  }
}
