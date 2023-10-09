import 'package:choice_bussiness/api/api_end_path.dart';
import 'package:choice_bussiness/pages/dashboard.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../styles/commonmodule/my_alert_dilog.dart';
import '../styles/commonmodule/my_snack_bar.dart';



class UploadMediaController extends GetxController{

  static UploadMediaController to = Get.find();
  final box = GetStorage();


  upload({dynamic imgPathList, videoPath}) async {
    MyAlertDialog.circularProgressDialog();


    var apiResponse = await ApiEndPath.uploadMedia(
        box.read('service_id'),service_image_List: imgPathList,service_video: videoPath);

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