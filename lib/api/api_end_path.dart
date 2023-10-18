import 'package:choice_bussiness/models/LgoinModel.dart';
import 'package:choice_bussiness/models/add_service_model.dart';
import 'package:choice_bussiness/models/fetch_portfolio_model.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/ResponseModel.dart';
import '../models/service_list_model.dart';
import '../models/sub_categoy_model.dart';
import '../models/upload_media_model.dart';

class ApiEndPath{
  static var client = http.Client();

  static Future<ResponseModel> registerUser(number, business_name, password, location, description) async {
    var baseurl = GlobalConfiguration().get('base_url');

    print('user reg data: number: $number, business_name: $business_name, password: $password, location: $location, description: $description');

   //number:7029869895
    // business_name:abc
    // password:12345678
    // location:durgapur
    // description:demo test

    var response = await client.post(Uri.parse('${baseurl}Registration-service-provider'), body: {
      'number': number,
      'business_name':business_name,
      'password':password,
      'location':location,
      'description':description
    });
    print('base url: $baseurl, response: $response');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return responseModelFromJson(jsonString);
    }
    return responseModelFromJson(response.body);
  }

  static Future<LoginModel> login(number, password) async {
    var baseurl = GlobalConfiguration().get('base_url');

    print('user login data: number: $number, password: $password');

   //number:9898989898
    // password:12345678

    var response = await client.post(Uri.parse('${baseurl}login-service-provider'), body: {
      'number': number,
      'password':password
    });
    print('base url: $baseurl, response: $response');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return loginModelFromJson(jsonString);
    }
    return loginModelFromJson(response.body);
  }

  static Future<AddServiceModel> addService
      (artist_id, category_id, subcategory_id, service_name, price,place,description,about)
  async {
    var baseurl = GlobalConfiguration().get('base_url');

    var response = await client.post(Uri.parse('${baseurl}add_service'),
        body: {
          'artist_id': artist_id,
          'category_id': category_id,
          'subcategory_id': subcategory_id,
          'service_name': service_name,
          'price': price,
          'place': place,
          'description': description,
          'about': about
    });

    if (response.statusCode == 200) {
      var jsonString = await response.body;

      return addServiceModelFromJson(jsonString);
    }
    return addServiceModelFromJson(response.body);
  }


  static Future<UploadMediaModel> uploadMedia
      (service_id, {dynamic service_image_List, service_video})
  async {
    var baseurl = GlobalConfiguration().get('base_url');

    var request = http.MultipartRequest('POST', Uri.parse('${baseurl}upload_service_media'));
    request.fields.addAll({
      'service_id': service_id
    });
    if(service_image_List.length == 0){}
    else{
    for (int i = 0; i < service_image_List.length; i++) {
      var filePath = service_image_List[i];
      var multipartFile = await http.MultipartFile.fromPath('service_image', filePath.toString());
      request.files.add(multipartFile);
    }}
    //request.files.add(await http.MultipartFile.fromPath('service_image', '/path/to/file'));
    if(service_video == null){}
    else {
      request.files.add(
          await http.MultipartFile.fromPath('service_video', service_video));
    }
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();

      return uploadMediaModelFromJson(jsonString);
    }
    return uploadMediaModelFromJson(response.reasonPhrase.toString());
  }

  static Future<SubCategoryModel> getSubCategories() async {
    var baseurl = GlobalConfiguration().get('base_url');



    var response = await client.post(Uri.parse('${baseurl}get-cat-subcat-service'));
    print('base url: $baseurl, response: $response');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return subCategoryModelFromJson(jsonString);
    }
    return subCategoryModelFromJson(response.body);
  }


  static Future<ServiceListModel> getAllServices(String artistId) async {
    var baseurl = GlobalConfiguration().get('base_url');



    var response = await client.get(Uri.parse('${baseurl}getUserBookingData?artist_id=$artistId'));
    print('base url: $baseurl, response: ${response.statusCode}');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return serviceListModelFromJson(jsonString);
    }
    return serviceListModelFromJson(response.body);
  }


  static Future<FetchPortfolioModel> getPortfolioDetails(String artistId) async {
    var baseurl = GlobalConfiguration().get('base_url');

    var response = await client.get(Uri.parse('${baseurl}getArtistPortfolio/$artistId'));
    print('base url: $baseurl, response: ${response.statusCode}');

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return fetchPortfolioModelFromJson(jsonString);
    }
    return fetchPortfolioModelFromJson(response.body);
  }
}