


import 'package:choice_bussiness/pages/dashboard.dart';
import 'package:choice_bussiness/pages/portfolio_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../api/api_end_path.dart';
import '../styles/commonmodule/my_alert_dilog.dart';
import '../styles/commonmodule/my_snack_bar.dart';

class SavePortfolioController extends GetxController{

  static SavePortfolioController to = Get.find();
  final box = GetStorage();


  save({dynamic imgPathList}) async {
    MyAlertDialog.circularProgressDialog();


    var apiResponse = await ApiEndPath.savePortfolio(
        box.read('userId'),portfolio_image_List: imgPathList,);

    if(apiResponse!=null){

      if(apiResponse.response=='ok'){
        Get.back();

        MySnackbar.successSnackBar(
          'Uploaded', 'Your media is uploaded',
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
