import 'package:choice_bussiness/api/api_end_path.dart';
import 'package:choice_bussiness/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../styles/commonmodule/my_alert_dilog.dart';
import '../styles/commonmodule/my_snack_bar.dart';


class ProfileUpdateController extends GetxController{
  static ProfileUpdateController to = Get.find();

  final box = GetStorage();

  TextEditingController business_name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController facebook_link = TextEditingController();
  TextEditingController insta_link = TextEditingController();



  profileUpdate ({var profilePhoto, coverPhoto}) async {
    print('details : '
        '${ box.read('userId')},${box.read('userNumber')}'
    );
    MyAlertDialog.circularProgressDialog();
    var apiResponse = await ApiEndPath.profileUpdate(
        box.read('userId'),
        business_name.text,
        box.read('userNumber'),
        box.read('registeredCategoryID'),
        box.read('location'),
        description.text,
        facebook_link.text,
        insta_link.text,
        profile_photo: profilePhoto,
        cover_photo: coverPhoto,
    );

    if(apiResponse!=null){
      if(apiResponse.response=='ok'){
        Get.back();
        MySnackbar.successSnackBar(
          'Success', apiResponse.message,
        );
        Get.offAll(()=> Dashboard());
      }
      else{
        Get.back();
        MySnackbar.errorSnackBar('Server Down', 'Please try again later');
        print('Response ------ ${apiResponse.response}');
      }

    }else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down ', 'Please try again later');
    }
  }





}
