import 'package:choice_bussiness/api/api_end_path.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/fetch_portfolio_model.dart';
import '../models/service_list_model.dart';
import '../styles/commonmodule/my_alert_dilog.dart';
import '../styles/commonmodule/my_snack_bar.dart';



class ServiceListController extends GetxController{
  static ServiceListController to = Get.find();
  var portfolioLoading = false.obs;
  var serviceDeleteLoading = false.obs;
  var serviceLoading = false.obs;
  var serviceList = <ServiceList>[].obs;
  var imageService = [].obs;
  var videoService = [].obs;
  final box = GetStorage();


  getServices() async {
    try {
      serviceLoading(true);
      var apiResponse = await ApiEndPath.getAllServices(box.read('userId'),box.read('location'));

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
      serviceLoading(false);
    }




  }

  serviceDeleting(service_id) async{
    try {
      serviceDeleteLoading(true);
      //MyAlertDialog.circularProgressDialog();

      var response = await ApiEndPath.serviceDelete(
        service_id,
      );

      print('service delete controller response: ${response.response}');
      if (response != null) {
        if (response.response == 'true') {
          MySnackbar.successSnackBar(
              'Service Deleted', response.message.toString());
          getServices();

          //Get.back();
          // Get.off(()=>Dashboard());
        } else {
          Get.back();
          MySnackbar.errorSnackBar(
              'Server Error', response.message.toString());
        }
      }
    } finally {
      try{
        serviceDeleteLoading(false);
      }catch(c){

      }
    }






  }

  var artisDetails = <ArtistPortfolio>[].obs;
  var artisImages = <PortfolioImage>[].obs;

  getPortfolioDetails() async {
    try {
      portfolioLoading(true);
      var apiResponse = await ApiEndPath.getPortfolioDetails(box.read('userId'));

      print(apiResponse.response);
      if (apiResponse != null) {
        if (apiResponse.response == 'ok') {
          artisDetails.assignAll(apiResponse.artistPortfolio);
          //print(artisMain.phoneNumber);
          if(apiResponse.artistPortfolio.isNotEmpty){
            artisImages.assignAll(apiResponse.artistPortfolio[0].portfolioImage);
            print(apiResponse.artistPortfolio[0].portfolioImage);
          }
          print(artisDetails.length);
        }
      }
    } finally {
      try{
        portfolioLoading(false);
      }catch(c){

      }
    }
  }

}
