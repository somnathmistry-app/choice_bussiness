import 'dart:async';
import 'package:choice_bussiness/pages/login.dart';
import 'package:choice_bussiness/styles/commonmodule/my_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/app_colors.dart';
class SplashView extends StatelessWidget {
  //const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    print('userId`````````````: ${box.read('userId')}');
//HomeController homeController = Get.put(HomeController());
    Timer(const Duration(seconds: 4), () {
     Get.offAll(LoginView());
      //homeController.getSliderList();
    });

    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            color: AppColors.themeColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
              'assets/images/logo.png',
              scale: 8,
            ),
                MyWidgets.textView('Business App', AppColors.themeColorTwo, 25, fontWeight: FontWeight.bold)
              ],
            )

            // Container(
            //     decoration: const BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage("assets/images/sp.jpg"),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     //Image.asset('assets/images/logo.png'),
            //     child: Center(
            //         child: Image.asset(
            //       'assets/images/logo.png',
            //       scale: 3,
            //     ))),
            ));
  }
}
