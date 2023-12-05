


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


  save({List<String>? imgPathList}) async {
    MyAlertDialog.circularProgressDialog();
    print('iamges str: portfolio imgs: ${imgPathList!.length}');


    for(var imagePath in imgPathList){
      var apiResponse = await ApiEndPath.savePortfolio(
        box.read('userId'),mediaFile: imagePath);

      if(apiResponse!=null){

        if(apiResponse.response=='ok'){
          MyAlertDialog.alertDialog('Uploading images please wait', 'Do not press back button or exit the app');
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
    Get.offAll(Dashboard());
    MySnackbar.infoSnackBar('Images Uploaded Successfully', '');


  }
}
