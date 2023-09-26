import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAlertDialog {
  static alertDialog(String title, String middleText) {
    Get.defaultDialog(
      title: title,
      titleStyle: TextStyle(fontSize: 20),
      middleText: middleText,
      radius: 2.0,
      // To Customize the middle text
      content: CircularProgressIndicator(),
      // cancel: RaisedButton(onPressed: (){}),
      // confirm: RaisedButton(onPressed: (){})
      barrierDismissible: false,
    );
  }

  static circularProgressDialog() {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
  }
}
