// To parse this JSON data, do
//
//     final deleteServiceImageModel = deleteServiceImageModelFromJson(jsonString);

import 'dart:convert';

DeleteServiceImageModel deleteServiceImageModelFromJson(String str) => DeleteServiceImageModel.fromJson(json.decode(str));

String deleteServiceImageModelToJson(DeleteServiceImageModel data) => json.encode(data.toJson());

class DeleteServiceImageModel {
  String response;
  String message;

  DeleteServiceImageModel({
    required this.response,
    required this.message,
  });

  factory DeleteServiceImageModel.fromJson(Map<String, dynamic> json) => DeleteServiceImageModel(
    response: json["response"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
  };
}
