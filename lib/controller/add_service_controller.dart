import 'package:choice_bussiness/api/api_end_path.dart';
import 'package:choice_bussiness/models/sub_categoy_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/location_list_model.dart';
import '../pages/upload_media.dart';
import '../styles/commonmodule/my_alert_dilog.dart';
import '../styles/commonmodule/my_snack_bar.dart';



class AddServiceController extends GetxController{
  static AddServiceController to = Get.find();

  final box = GetStorage();

  TextEditingController serviceName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController about = TextEditingController();
  String? subCategory;


  addService () async {

    print('my id :${box.read('userId')}');
    print(subCategory);
    print(serviceName.text);
    print(price.text);
    print(selectedLocation);
    print(description.text);
    print(about.text);
    MyAlertDialog.circularProgressDialog();
    var apiResponse = await ApiEndPath.addService(
        box.read('userId'), box.read('registeredCategoryID'), subCategory, box.read('businessName'), price.text, selectedLocation, description.text, about.text
    );

    if(apiResponse!=null){
      if(apiResponse.response=='ok'){
        Get.back();
        MySnackbar.successSnackBar(
          'Success', 'Service has been added',
        );
        Get.off(()=> UploadMedia());
      }
      // else if(apiResponse.response != 'ok') {
      //   Get.back();
      //   MySnackbar.errorSnackBar('Failed', apiResponse.response.toString());
      //   print('Response ------ ${apiResponse.response}');
      // }
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


  var isLoading = false.obs;
  var allCatList = <Subcat>[].obs;
  var mySubCats;
  var allSubCatList = [].obs;
  var allSubCatListID = [].obs;
  getSubCategory () async {
    try {
      print(box.read('registeredCategoryID'));
      isLoading(true);
      var apiResponse = await ApiEndPath.getSubCategories();

      if (apiResponse != null) {
        if (apiResponse.response == 'ok') {
          allCatList.assignAll(apiResponse.catsubcat);
          //allCatList.map((element) => allSubCatList.assign(element));
          // print(apiResponse.catsubcat[0].subcat![0].photo);
          mySubCats = allCatList.firstWhere(
                (category) => category.id == '28',
            orElse: () => Subcat(
              id: '',
              title: '', slug: '', summary: null, isParent: '', parentId: null,
            ),
          );
           print(mySubCats);

          if (mySubCats.subcat != null && mySubCats.subcat!.isNotEmpty) {
            allSubCatList.assignAll(mySubCats.subcat);
            allSubCatListID.assign(mySubCats.subcat!.map((subcat) => subcat.id));
          }

        }
      }
    } finally {
      isLoading(false);
    }
  }


  var isLoading2 = false.obs;
  var locationData = <LocationData>[].obs;
  String? selectedLocation;

  getLocationList() async {
    try {
      isLoading2(true);
      var apiResponse = await ApiEndPath.getLocationList();
      if (apiResponse != null) {
        if (apiResponse.response == 'true') {
          locationData.assignAll(apiResponse.data);
          print('Location ${locationData.length}');
        }
      }
    } finally {
      isLoading2(false);
    }
  }
}
