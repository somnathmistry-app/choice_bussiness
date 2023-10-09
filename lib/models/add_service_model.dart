// To parse this JSON data, do
//
//     final addServiceModel = addServiceModelFromJson(jsonString);

import 'dart:convert';

AddServiceModel addServiceModelFromJson(String str) => AddServiceModel.fromJson(json.decode(str));

String addServiceModelToJson(AddServiceModel data) => json.encode(data.toJson());

class AddServiceModel {
  String response;
  int serviceId;
  String message;
  int status;

  AddServiceModel({
    required this.response,
    required this.serviceId,
    required this.message,
    required this.status,
  });

  factory AddServiceModel.fromJson(Map<String, dynamic> json) => AddServiceModel(
    response: json["response"],
    serviceId: json["service_id"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "service_id": serviceId,
    "message": message,
    "status": status,
  };
}
