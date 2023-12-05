import 'package:choice_bussiness/api/api_end_path.dart';
import 'package:choice_bussiness/pages/dashboard.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../styles/commonmodule/my_alert_dilog.dart';
import '../styles/commonmodule/my_snack_bar.dart';



class UploadMediaController extends GetxController{

  static UploadMediaController to = Get.find();
  final box = GetStorage();


  upload(String serviceId,{dynamic imgPathList, videoPath}) async {
    MyAlertDialog.circularProgressDialog();

print(box.read('userId'));
print(imgPathList);
for(var imageFile in imgPathList){
  var apiResponse = await ApiEndPath.uploadMedia(serviceId,mediaFile: imageFile);

  if(apiResponse!=null){

    if(apiResponse.response=='ok'){
      MyAlertDialog.alertDialog('Your service is uploading please wait..', 'Do not press back button or exit the app');
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
    Get.offAll(()=> Dashboard());
MySnackbar.successSnackBar('Service uploaded successfully', '');

  }
}
