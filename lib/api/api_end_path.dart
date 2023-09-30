import 'package:choice_bussiness/models/LgoinModel.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/ResponseModel.dart';

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





}