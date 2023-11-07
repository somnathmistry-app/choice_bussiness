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

  ProfileUpdateModel({
    required this.response,
    required this.message,
    required this.status,
  });

  factory ProfileUpdateModel.fromJson(Map<String, dynamic> json) => ProfileUpdateModel(
    response: json["response"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "status": status,
  };
}
