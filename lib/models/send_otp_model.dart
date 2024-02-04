// To parse this JSON data, do
//
//     final sendOtpModel = sendOtpModelFromJson(jsonString);

import 'dart:convert';

SendOtpModel sendOtpModelFromJson(String str) => SendOtpModel.fromJson(json.decode(str));

String sendOtpModelToJson(SendOtpModel data) => json.encode(data.toJson());

class SendOtpModel {
  String? response;
  String? message;
  int? otp;

  SendOtpModel({
    this.response,
    this.message,
    this.otp,
  });

  factory SendOtpModel.fromJson(Map<String, dynamic> json) => SendOtpModel(
    response: json["response"],
    message: json["message"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "otp": otp,
  };
}
