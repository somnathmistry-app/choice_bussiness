import 'package:choice_bussiness/api/api_end_path.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/service_list_model.dart';



class ServiceListController extends GetxController{
  static ServiceListController to = Get.find();
  var isLoading = false.obs;
  var serviceList = <ServiceList>[].obs;
  var imageService = [].obs;
  var videoService = [].obs;
  final box = GetStorage();


  getServices() async {
    try {
      isLoading(true);
      var apiResponse = await ApiEndPath.getAllServices(box.read('userId'));

      if (apiResponse != null) {
        if (apiResponse.response == 'ok') {
          serviceList.assignAll(apiResponse.serviceList);
          print(serviceList.length);
          imageService.clear();
          videoService.clear();
          for (var service in apiResponse.serviceList) {
            if (service.serviceImage != null && service.serviceImage!.isNotEmpty) {
              imageService.add(service.serviceImage![0].photo);
            } else {
              imageService.add(''); // You can add a placeholder or an add icon here.
            }

            if (service.serviceVideo != null && service.serviceVideo!.isNotEmpty) {
              videoService.add(service.serviceVideo![0].video);
            } else {
              videoService.add(''); // You can add a placeholder or an add icon here.
            }
          }
          print(imageService.length);
          print(videoService.length);

        }
      }
    } finally {
      isLoading(false);
    }
  }

}
