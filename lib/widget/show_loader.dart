import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tl_customer/const/Image.dart';

class LoaderDialog extends StatelessWidget {
  const LoaderDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(50),
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2)),
              child: Image.asset(
                Images.loadingGIF,
                height: Get.width * 0.15,
              ),
            )
          ]),
        )
      ],
    );
  }

  showLoader() {
    Get.dialog(
      const LoaderDialog(),
    );
  }

  hideLoader() {
    Get.close(1);
  }
}
