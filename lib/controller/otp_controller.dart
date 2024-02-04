import 'package:choice_bussiness/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/api_end_path.dart';
import '../pages/forget_password/enter_otp.dart';
import '../pages/forget_password/new_password.dart';
import '../styles/commonmodule/my_alert_dilog.dart';
import '../styles/commonmodule/my_snack_bar.dart';

class OtpController extends GetxController {
  static OtpController to = Get.find();

  static TextEditingController number = TextEditingController();
  static TextEditingController new_password = TextEditingController();

  GetStorage box = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }


  sendOtp() async{
    MyAlertDialog.circularProgressDialog();

    var response = await ApiEndPath.sendOtp(
        number.text,
    );

    if (response != null) {
      if (response.response == 'ok') {
        MySnackbar.successSnackBar(
            'OTP : ${response.otp.toString()}', 'Please enter the OTP to proceed');
        Get.off(()=> EnterOTPPage( number: number.text,));
        box.write('MyOTP', response.otp);
      } else {
        Get.back();
        MySnackbar.errorSnackBar(
            'Invalid Phone Number', response.message.toString());
      }
    }
  }

  verify(String otp) async{
    MyAlertDialog.circularProgressDialog();

    if (box.read('MyOTP') != null) {
      if (box.read('MyOTP').toString() == otp) {
        MySnackbar.successSnackBar(
            'Verified', 'Welcome to choice 99');
        Get.off(()=> NewPasswordPage());
      } else {
        Get.back();
        MySnackbar.errorSnackBar(
            'Invalid OTP ', 'Please enter the correct OTP');
      }
    }
  }

  changePassword() async{
    MyAlertDialog.circularProgressDialog();

    var response = await ApiEndPath.changePassword(
      number.text,
      new_password.text,
    );

    if (response != null) {
      if (response.response == 'ok') {
        MySnackbar.successSnackBar(
            'Password Updated', 'Your new password has been successfully updated');
        Get.offAll(()=> LoginView());
      } else {
        Get.back();
        MySnackbar.errorSnackBar(
            'Server Error', response.message.toString());
      }
    }
  }
}
