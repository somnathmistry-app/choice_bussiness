import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

class MyAlertDialog {
  static alertDialog(String title, String middleText) {
    Get.defaultDialog(
      title: title,
      titleStyle: const TextStyle(fontSize: 20),
      middleText: middleText,
      radius: 2.0,
      // To Customize the middle text
      content: const CircularProgressIndicator(),
      // cancel: RaisedButton(onPressed: (){}),
      // confirm: RaisedButton(onPressed: (){})
      barrierDismissible: false,
    );
  }

  static circularProgressDialog() {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
  }
  static percentProgressBar(BuildContext context){
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width - 50,
        animation: true,
        lineHeight: 20.0,
        animationDuration: 2000,
        percent: 0.9,
        center: const Text("90.0%"),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Colors.greenAccent,
      ),
    );
  }
}
