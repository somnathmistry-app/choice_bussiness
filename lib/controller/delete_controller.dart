import 'package:choice_bussiness/pages/dashboard.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/api_end_path.dart';
import '../styles/commonmodule/my_alert_dilog.dart';
import '../styles/commonmodule/my_snack_bar.dart';

class DeleteController extends GetxController {
  static DeleteController to = Get.find();

  GetStorage box = GetStorage();

  serviceDeleting(service_id) async{
    MyAlertDialog.circularProgressDialog();

    var response = await ApiEndPath.serviceDelete(
      service_id,
    );

    print('login controller response: ${response.response}');
    if (response != null) {
      if (response.response == 'true') {
        MySnackbar.successSnackBar(
            'Service Deleted', response.message.toString());
        Get.offAll(()=>Dashboard());
      } else {
        Get.back();
        MySnackbar.errorSnackBar(
            'Server Error', response.message.toString());
      }
    }
  }

  deleteImagePortfolio(imagename) async{
    MyAlertDialog.circularProgressDialog();

    var response = await ApiEndPath.deleteServiceImage(
      imagename,
    );

    print('login controller response: ${response.response}');
    if (response != null) {
      if (response.response == 'true') {
        MySnackbar.successSnackBar(
            'Image Deleted', response.message.toString());
        Get.offAll(()=>Dashboard());
      } else {
        Get.back();
        MySnackbar.errorSnackBar(
            'Server Error', response.message.toString());
      }
    }
  }
}
