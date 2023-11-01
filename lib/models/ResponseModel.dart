// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  String response;
  String message;
  List<UserDetail> userDetail;

  RegisterModel({
    required this.response,
    required this.message,
    required this.userDetail,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    response: json["response"],
    message: json["message"],
    userDetail: List<UserDetail>.from(json["userDetail"].map((x) => UserDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "userDetail": List<dynamic>.from(userDetail.map((x) => x.toJson())),
  };
}

class UserDetail {
  int id;
  String businessName;
  String phoneNumber;
  String categoryId;
  String password;
  String location;
  dynamic profilePhoto;
  String description;
  DateTime createdAt;
  DateTime updatedAt;

  UserDetail({
    required this.id,
    required this.businessName,
    required this.phoneNumber,
    required this.categoryId,
    required this.password,
    required this.location,
    required this.profilePhoto,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    id: json["id"],
    businessName: json["business_name"],
    phoneNumber: json["phone_number"],
    categoryId: json["category_id"],
    password: json["password"],
    location: json["location"],
    profilePhoto: json["profile_photo"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_name": businessName,
    "phone_number": phoneNumber,
    "category_id": categoryId,
    "password": password,
    "location": location,
    "profile_photo": profilePhoto,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
