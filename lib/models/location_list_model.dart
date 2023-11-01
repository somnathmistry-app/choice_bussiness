// To parse this JSON data, do
//
//     final locationListModel = locationListModelFromJson(jsonString);

import 'dart:convert';

LocationListModel locationListModelFromJson(String str) => LocationListModel.fromJson(json.decode(str));

String locationListModelToJson(LocationListModel data) => json.encode(data.toJson());

class LocationListModel {
  String response;
  List<LocationData> data;
  String message;

  LocationListModel({
    required this.response,
    required this.data,
    required this.message,
  });

  factory LocationListModel.fromJson(Map<String, dynamic> json) => LocationListModel(
    response: json["response"],
    data: List<LocationData>.from(json["data"].map((x) => LocationData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class LocationData {
  String id;
  String name;

  LocationData({
    required this.id,
    required this.name,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
