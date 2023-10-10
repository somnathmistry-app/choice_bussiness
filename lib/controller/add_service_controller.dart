import 'package:choice_bussiness/api/api_end_path.dart';
import 'package:choice_bussiness/models/sub_categoy_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../pages/upload_media.dart';
import '../styles/commonmodule/my_alert_dilog.dart';
import '../styles/commonmodule/my_snack_bar.dart';



class AddServiceController extends GetxController{
  static AddServiceController to = Get.find();

  final box = GetStorage();
  var categoryy = '1';
  var subCategoryy = '';

  TextEditingController serviceName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController about = TextEditingController();
  List<String> categoryList = ['1', '2', '3', '4'];
  List<String> subCategoryList = ['1', '2', '3', '4'];
  String? category;
  String? subCategory;
  List<String> locations = ['Durgapur', 'Kolkata', 'Asansol', 'Bankura']; // Option 2
  String? selectedLocation;


  addService () async {

    print('my id :${box.read('userId')}');
    print(category);
    print(subCategory);
    print(serviceName.text);
    print(price.text);
    print(selectedLocation);
    print(description.text);
    print(about.text);
    MyAlertDialog.circularProgressDialog();
    var apiResponse = await ApiEndPath.addService(
        box.read('userId'), category, subCategory, serviceName.text, price.text, selectedLocation, description.text, about.text
    );

    if(apiResponse!=null){
      if(apiResponse.response=='ok'){
        Get.back();
        box.write('service_id', category);
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
  var allSubCatList = [].obs;
  var allSubCatListID = [].obs;
  getSubCategory () async {
    try {
      isLoading(true);
      var apiResponse = await ApiEndPath.getSubCategories();

      if (apiResponse != null) {
        if (apiResponse.response == 'ok') {
          allCatList.assignAll(apiResponse.catsubcat);
          print(apiResponse.catsubcat[0].subcat![0].photo);
          for (var element in allCatList) {
            if(element.subcat!.isEmpty){

            }else{
              allSubCatListID.add(element.subcat![0].id);
              allSubCatList.add(element.subcat);
            }
            //print(element.subcat);
           // element.subcat!.map((e) => print(e));


          }
        }
      }
    } finally {
      isLoading(false);
    }
  }
}