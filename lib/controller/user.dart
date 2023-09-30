import 'package:choice_bussiness/pages/home.dart';
import 'package:choice_bussiness/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/api_end_path.dart';
import '../styles/commonmodule/my_alert_dilog.dart';
import '../styles/commonmodule/my_snack_bar.dart';

class UserController extends GetxController {
  static TextEditingController mobileTec_login = TextEditingController();
  static TextEditingController passTec_login = TextEditingController();


  static TextEditingController businessTec = TextEditingController();
  static TextEditingController mobileTec = TextEditingController();
  static TextEditingController passTec = TextEditingController();
  static TextEditingController descriptionTec = TextEditingController();
  List<String> locations = ['Durgapur', 'Kolkata', 'Asansol', 'Bankura']; // Option 2
  String? selectedLocation;

  var otpSent= false.obs;
  GetStorage box = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //print('date is: ${dobController.text}');
  }

/*  getRegister() async {
    MyAlertDialog.circularProgressDialog();

    //   //email:sam2@gmail.com
    //     // passwd:123456
    //     // FName:Sam2
    //     // LName:Smith
    //     // phno:9876543210
    var response = await RegisterApi.verifyOTP(
        mobileController.text
    );

    print('register controller response: ${response.message}');
    if (response != null) {
      if (response.message == 'otp sent success') {
        Get.back();
        Get.to(OTPVerifyPage(response.oto, response.usertype!));
        box.write('userId', response.userId);
        box.write('mobile', mobileController.text);
        box.write('name', nameController.text);
      } else {
        Get.back();
        MySnackbar.errorSnackBar(
            'Registration failed', 'Server down, please try again later');

      }
    }
  }

  verifyAndRegisterUser (int apiOTP, int userOTP, String userType){
    print('apiOTP $apiOTP, userOTP: $userOTP, userType: $userType');
    if(apiOTP==userOTP){
      if(userType=='new'){
        registerUser();
      }else{
        Get.offAll(PagesView());
      }
      //
    }else{
      MySnackbar.infoSnackBar('OTP did not match', '');
    }
  }*/

  //number:7029869895
  // business_name:abc
  // password:12345678
  // location:durgapur
  // description:demo test

  registerUser() async{
    MyAlertDialog.circularProgressDialog();

    var response = await ApiEndPath.registerUser(
        mobileTec.text,
      businessTec.text,
      passTec.text,
      selectedLocation,
      descriptionTec.text
    );

    print('register controller response: ${response.response}');
    if (response != null) {
      if (response.response == 'ok') {
        MySnackbar.successSnackBar(
            'Registration Success', 'please login to enter');
        Get.offAll(LoginView());
      } else {
        Get.back();
        MySnackbar.errorSnackBar(
            'Registration failed', 'please try again later');

      }
    }
  }

  loginUser() async{
    MyAlertDialog.circularProgressDialog();

    var response = await ApiEndPath.login(
        mobileTec_login.text,
        passTec_login.text
    );

    print('login controller response: ${response.response}');
    if (response != null) {
      if (response.response == 'ok') {
        MySnackbar.successSnackBar(
            'Login Success', 'Welcome to choice 99');
        Get.offAll(HomePage());

      } else {
        Get.back();
        MySnackbar.errorSnackBar(
            'Incorrect Details', 'Mobile no or password incorrect');

      }
    }
  }

}
