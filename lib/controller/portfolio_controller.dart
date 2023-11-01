import 'package:choice_bussiness/api/api_end_path.dart';
import 'package:choice_bussiness/models/fetch_portfolio_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';




class PortfolioController extends GetxController{
  static PortfolioController to = Get.find();
  var isLoading = false.obs;
  final box = GetStorage();
  var artisDetails = <ArtistPortfolio>[].obs;
  var artisImages = <PortfolioImage>[].obs;
  var artisVideos = <PortfolioVideo>[].obs;


  getPortfolioDetails() async {
    try {
      isLoading(true);
      var apiResponse = await ApiEndPath.getPortfolioDetails(box.read('userId'));

      print(apiResponse.response);
      if (apiResponse != null) {
        if (apiResponse.response == 'ok') {
          artisDetails.assignAll(apiResponse.artistPortfolio);
          //print(artisMain.phoneNumber);
          if(apiResponse.artistPortfolio.isNotEmpty){
            artisImages.assignAll(apiResponse.artistPortfolio[0].portfolioImage);
            print(apiResponse.artistPortfolio[0].portfolioImage);
            artisVideos.assignAll(apiResponse.artistPortfolio[0].portfolioVideo);
          }
          print(artisDetails.length);
        }
      }
    } finally {
      isLoading(false);
    }
  }

}
