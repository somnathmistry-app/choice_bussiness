// To parse this JSON data, do
//
//     final uploadMediaModel = uploadMediaModelFromJson(jsonString);

import 'dart:convert';

UploadMediaModel uploadMediaModelFromJson(String str) => UploadMediaModel.fromJson(json.decode(str));

String uploadMediaModelToJson(UploadMediaModel data) => json.encode(data.toJson());

class UploadMediaModel {
  String response;
  String message;
  int status;

  UploadMediaModel({
    required this.response,
    required this.message,
    required this.status,
  });

  factory UploadMediaModel.fromJson(Map<String, dynamic> json) => UploadMediaModel(
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
