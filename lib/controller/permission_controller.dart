
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController{

  static Future<void> requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (status.isDenied) {
      //requestStoragePermission();
      //openAppSettings();
      // Permission granted, proceed with file picking.
    } else if (status.isPermanentlyDenied){
      //openAppSettings();
      // Permission denied, handle accordingly.
    }
  }
}