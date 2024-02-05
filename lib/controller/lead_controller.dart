import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../api/api_end_path.dart';
import '../models/lead_model.dart';


class LeadController extends GetxController{
  var leadList = <LeadList>[].obs;
  final box = GetStorage();
  var leadLoading = false.obs;

  getLead() async {
    print('lead user id ');
    try {
      leadLoading(true);
      var apiResponse = await ApiEndPath.getLead(box.read('userId'));
      if (apiResponse != null) {
        if (apiResponse.response == 'true') {
          leadList.assignAll(apiResponse.data!);
        }
      }
    } finally {
      leadLoading(false);
    }
  }
}