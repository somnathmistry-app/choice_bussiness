// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? response;
  String? message;
  Data? data;

  LoginModel({
    this.response,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    response: json["response"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? businessName;
  String? phoneNumber;
  String? password;
  String? location;
  dynamic profilePhoto;
  String? description;

  Data({
    this.id,
    this.businessName,
    this.phoneNumber,
    this.password,
    this.location,
    this.profilePhoto,
    this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    businessName: json["business_name"],
    phoneNumber: json["phone_number"],
    password: json["password"],
    location: json["location"],
    profilePhoto: json["profile_photo"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_name": businessName,
    "phone_number": phoneNumber,
    "password": password,
    "location": location,
    "profile_photo": profilePhoto,
    "description": description,
  };
}
