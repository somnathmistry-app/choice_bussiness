// To parse this JSON data, do
//
//     final profileUpdateModel = profileUpdateModelFromJson(jsonString);

import 'dart:convert';

ProfileUpdateModel profileUpdateModelFromJson(String str) => ProfileUpdateModel.fromJson(json.decode(str));

String profileUpdateModelToJson(ProfileUpdateModel data) => json.encode(data.toJson());

class ProfileUpdateModel {
  String response;
  String message;
  int status;
  Data data;

  ProfileUpdateModel({
    required this.response,
    required this.message,
    required this.status,
    required this.data,
  });

  factory ProfileUpdateModel.fromJson(Map<String, dynamic> json) => ProfileUpdateModel(
    response: json["response"],
    message: json["message"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String businessName;
  dynamic phoneNumber;
  String categoryId;
  String password;
  dynamic location;
  String profilePhoto;
  dynamic coverPhoto;
  dynamic description;
  String facebookLink;
  dynamic instagramLink;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.businessName,
    required this.phoneNumber,
    required this.categoryId,
    required this.password,
    required this.location,
    required this.profilePhoto,
    required this.coverPhoto,
    required this.description,
    required this.facebookLink,
    required this.instagramLink,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    businessName: json["business_name"]??'',
    phoneNumber: json["phone_number"]??'',
    categoryId: json["category_id"]??'',
    password: json["password"]??'',
    location: json["location"]??'',
    profilePhoto: json["profile_photo"]??'',
    coverPhoto: json["cover_photo"]??'',
    description: json["description"]??'',
    facebookLink: json["facebook_link"] ?? '',
    instagramLink: json["instagram_link"]??'',
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
    "cover_photo": coverPhoto,
    "description": description,
    "facebook_link": facebookLink,
    "instagram_link": instagramLink,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
