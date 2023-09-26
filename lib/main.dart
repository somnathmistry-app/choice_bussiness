import 'package:choice_bussiness/pages/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  //var box = GetStorage();
  //const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // if(box.read('userId')==null || box.read('userId')==""){
    //   box.write('userId', '2');
    // }
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Choice Admin',
      theme: ThemeData(
        fontFamily: 'Mulish-Medium',
        primarySwatch: Colors.orange,
      ),
      home: SplashView(),
    );
  }
}

