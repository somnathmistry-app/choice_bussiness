import 'package:choice_bussiness/models/LgoinModel.dart';
import 'package:choice_bussiness/models/add_service_model.dart';
import 'package:choice_bussiness/models/delete_image_model.dart';
import 'package:choice_bussiness/models/fetch_portfolio_model.dart';
import 'package:choice_bussiness/models/location_list_model.dart';
import 'package:choice_bussiness/models/profile_update_model.dart';
import 'package:choice_bussiness/models/save_portfolio.dart';
import 'package:choice_bussiness/models/service_delete_model.dart';
import 'package:get/get.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/ResponseModel.dart';
import '../models/lead_model.dart';
import '../models/service_list_model.dart';
import '../models/sub_categoy_model.dart';
import '../models/upload_media_model.dart';

class ApiEndPath{
  static String imageURL = 'https://psbeauty.co.in/app/public/service_image/';
  static var client = http.Client();
  static var baseurl = GlobalConfiguration().get('base_url');
  static Future<RegisterModel> registerUser(
      number, business_name, category_id,
      password, location, description) async {


    print('user reg data: number: $number,'
        ' business_name: $business_name,category_id $category_id,'
        ' password: $password, location: $location, description: $description');

   //number:7029869895
    // business_name:abc
    // password:12345678
    // location:durgapur
    // description:demo test

    var response = await client.post(Uri.parse('${baseurl}Registration-service-provider'), body: {
      'number': number,
      'business_name': business_name,
      'category_id': category_id,
      'password': password,
      'location': location,
      'description': description
    });
    print('base url: $baseurl, response: $response');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return registerModelFromJson(jsonString);
    }
    return registerModelFromJson(response.body);
  }

  static Future<LoginModel> login(number, password) async {

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


  static Future<UploadMediaModel> uploadMedia(service_id, {dynamic mediaFile})
  async {

    var request = http.MultipartRequest('POST', Uri.parse('${baseurl}upload_service_media'));
    request.fields.addAll({
      'service_id': service_id
    });
    if(mediaFile != null){}

    //for (int i = 0; i < service_image_List.length; i++) {
      var multipartFile = await http.MultipartFile.fromPath('service_image', mediaFile.toString());
      request.files.add(multipartFile);
  //  }
    //request.files.add(await http.MultipartFile.fromPath('service_image', '/path/to/file'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();

      return uploadMediaModelFromJson(jsonString);
    }
    return uploadMediaModelFromJson(response.reasonPhrase.toString());
  }

  static Future<SubCategoryModel> getSubCategories() async {

    var response = await client.post(Uri.parse('${baseurl}get-cat-subcat-service'));
    print('base url: $baseurl, response: $response');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return subCategoryModelFromJson(jsonString);
    }
    return subCategoryModelFromJson(response.body);
  }


  static Future<ServiceListModel> getAllServices(String artistId,String place) async {


    var response = await client.get(Uri.parse('${baseurl}getServiceList?artist=$artistId'));
    print('base url: $baseurl, response: ${response.statusCode}');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return serviceListModelFromJson(jsonString);
    }
    return serviceListModelFromJson(response.body);
  }


  static Future<LeadModel> getLead(String artistId) async {
    var response = await client.get(Uri.parse('${baseurl}lead-entry?artist_id=$artistId'));
    print('base url: $baseurl, response: ${response.statusCode}');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return leadModelFromJson(jsonString);
    }
    return leadModelFromJson(response.body);
  }

  static Future<FetchPortfolioModel> getPortfolioDetails(String artistId) async {

    var response = await client.get(Uri.parse('${baseurl}getArtistPortfolio/$artistId'));
    print('base url: $baseurl, response: ${response.statusCode}');

    if (response.statusCode == 200) {
      var jsonString = response.body;
      return fetchPortfolioModelFromJson(jsonString);
    }
    return fetchPortfolioModelFromJson(response.body);
  }


  static Future<SavePortfolioModel> savePortfolio(String artistId,
      {mediaFile}) async {

    var request = http.MultipartRequest('POST', Uri.parse('${baseurl}saveArtistPortfolio'));
    print('artistlist: $baseurl, artistid:- $artistId, imgs:- $mediaFile');
    request.fields.addAll({
      'artist_id': artistId
    });
    if(mediaFile!=null){
    //for(var i in portfolio_image_List) {
      var multipartFile = await http.MultipartFile.fromPath('portfolio_image', mediaFile.toString());
      request.files.add(multipartFile);
    //}

    }
    /*if(portfolio_image_List!.length > 0){
      print(portfolio_image_List);
      for (int i = 0; i <= portfolio_image_List.length; i++) {
        var filePath = portfolio_image_List[i];
        var multipartFile = await http.MultipartFile.fromPath('portfolio_image', filePath.toString());
        request.files.add(multipartFile);
      }
    }*/
    else{
      }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      return savePortfolioModelFromJson(jsonString);
    }
    return savePortfolioModelFromJson(response.reasonPhrase.toString());
  }




  static Future<LocationListModel> getLocationList() async {
    var response = await client.post(Uri.parse('${baseurl}city_list'));
    print('base url: $baseurl, response: $response');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return locationListModelFromJson(jsonString);
    }
    return locationListModelFromJson(response.body);
  }

  static Future<ProfileUpdateModel> profileUpdate
      (artist_id,  business_name, number,category_id,location, description, facebook_link,instagram_link,
      {var profile_photo, cover_photo}
      )
  async {
    var request = http.MultipartRequest('POST',
        Uri.parse('${baseurl}updateArtistProfile'));
    request.fields.addAll({
      'artist_id': artist_id,
      'business_name': business_name,
      'phone_number': number,
      'category_id': category_id,
      'location': location,
      'description': description,
      'facebook_link': facebook_link,
      'instagram_link': instagram_link
    });
    if(profile_photo == null || profile_photo == ''){
    }else{
      request.files.add(await http.MultipartFile.fromPath('profile_photo', profile_photo));
    }
    if(cover_photo == null || cover_photo == ''){}else{
      request.files.add(await http.MultipartFile.fromPath('cover_photo', cover_photo));
    }

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();

      return profileUpdateModelFromJson(jsonString);
    }
    return profileUpdateModelFromJson(response.reasonPhrase.toString());
  }

  static Future<ServiceDeleteModel> serviceDelete(service_id) async {
    print('user login data: service_id: $service_id');
    var response = await client.post(Uri.parse('${baseurl}delete_service'), body: {
      'service_id': service_id,
    });
    print('base url: $baseurl, response: $response');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return serviceDeleteModelFromJson(jsonString);
    }
    return serviceDeleteModelFromJson(response.body);
  }

  static Future<DeleteServiceImageModel> deleteServiceImage(String imagename) async {
    //List<String> imageId = imagename.split('.');
    print('user portfolio delete data: imagename: $imagename');

    var response = await client.post(Uri.parse('${baseurl}delete_service_image'), body: {
      'imagename': imagename,
    });
    print('base url: $baseurl, response: $response');

    if (response.statusCode == 200) {
      var jsonString = response.body;

      return deleteServiceImageModelFromJson(jsonString);
    }
    return deleteServiceImageModelFromJson(response.body);
  }
}
