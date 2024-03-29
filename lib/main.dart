import 'package:choice_bussiness/controller/delete_controller.dart';
import 'package:choice_bussiness/controller/otp_controller.dart';
import 'package:choice_bussiness/controllers.dart';
import 'package:choice_bussiness/pages/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';

import 'controller/profile_update_controller.dart';
import 'controller/save_image_controller.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("config");
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  Get.put<AddServiceController>(AddServiceController());
  Get.put<UploadMediaController>(UploadMediaController());
  Get.put<ServiceListController>(ServiceListController());
  Get.put<PortfolioController>(PortfolioController());
  Get.put<SavePortfolioController>(SavePortfolioController());
  Get.put<ProfileUpdateController>(ProfileUpdateController());
  Get.put<DeleteController>(DeleteController());
  Get.put<OtpController>(OtpController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        useMaterial3: false,
        fontFamily: 'Mulish-Medium',
        primarySwatch: Colors.orange,
      ),
      home: SplashView(),
    );
  }
}

