import 'package:choice_bussiness/api/api_end_path.dart';
import 'package:choice_bussiness/models/fetch_portfolio_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/service_list_model.dart';



class PortfolioController extends GetxController{
  static PortfolioController to = Get.find();
  var isLoading = false.obs;
  final box = GetStorage();
  dynamic artisMain;
  var artisDetails = <ArtistPortfolioElement>[].obs;


  getPortfolioDetails() async {
    try {
      isLoading(true);
      var apiResponse = await ApiEndPath.getPortfolioDetails('2');

      if (apiResponse != null) {
        if (apiResponse.response == 'ok') {
          artisMain = apiResponse.artistPortfolio;
          print(artisMain.phoneNumber);
          if(apiResponse.artistPortfolio.artistPortfolio.isNotEmpty){
            artisDetails.assignAll(apiResponse.artistPortfolio.artistPortfolio);
          }
          print(artisDetails.length);
        }
      }
    } finally {
      isLoading(false);
    }
  }

}