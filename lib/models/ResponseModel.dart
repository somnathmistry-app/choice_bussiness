import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  String? response;
  String? message;

  ResponseModel({
    this.response,
    this.message,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    response: json["response"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
  };
}
