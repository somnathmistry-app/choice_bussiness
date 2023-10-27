import 'package:choice_bussiness/api/api_end_path.dart';
import 'package:choice_bussiness/styles/commonmodule/app_bar.dart';
import 'package:get/get.dart';

import '../models/service_list_model.dart';



class ServiceListController extends GetxController{
  static ServiceListController to = Get.find();
  var isLoading = false.obs;
  var serviceList = <ServiceList>[].obs;
  var bookingList = <BookingList>[].obs;


  getServices() async {
    try {
      isLoading(true);
      var apiResponse = await ApiEndPath.getAllServices('1');

      if (apiResponse != null) {
        if (apiResponse.response == 'ok') {
          bookingList.assignAll(apiResponse.bookingList!);
          print(bookingList.length);
          serviceList.clear();
          for(int i = 0; i < apiResponse.bookingList!.length; i++){
            serviceList.addAll(bookingList[i].serviceList!);
          }
          print(serviceList.length);

        }
      }
    } finally {
      isLoading(false);
    }
  }

}