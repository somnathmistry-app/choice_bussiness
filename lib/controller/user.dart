import 'package:choice_bussiness/pages/dashboard.dart';
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
  String? selectedCatID;

  var otpSent= false.obs;
  GetStorage box = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  registerUser() async{
    MyAlertDialog.circularProgressDialog();

    var response = await ApiEndPath.registerUser(
        mobileTec.text,
        businessTec.text,
        selectedCatID,
        passTec.text,
        selectedLocation,
        descriptionTec.text
    );

    print('register controller response: ${response.response}');
    if (response != null) {
      if (response.response == 'ok') {
        MySnackbar.successSnackBar(
            'Registration Success', 'please login to enter');
        box.write('registeredCategoryID', response.userDetail[0].categoryId);
        box.write('businessName', response.userDetail[0].businessName);
        Get.offAll(const LoginView());
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
        Get.offAll(()=>Dashboard());
        box.write('userId', response.data!.id.toString());
        box.write('businessName', response.data!.businessName.toString());
        box.write('userPhoto', response.data!.profilePhoto.toString());
        box.write('userLocation', response.data!.location.toString());
        box.write('email', response.data!..toString());
        box.write('registeredCategoryID', response.data!.categoryId);

      } else {
        Get.back();
        MySnackbar.errorSnackBar(
            'Incorrect Details', 'Mobile no or password incorrect');

      }
    }
  }
}
