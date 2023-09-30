import 'package:choice_bussiness/pages/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("config");
  await GetStorage.init();

  runApp(MyApp());
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

