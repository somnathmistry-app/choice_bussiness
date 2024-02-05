// To parse this JSON data, do
//
//     final serviceListModel = serviceListModelFromJson(jsonString);

import 'dart:convert';

ServiceListModel serviceListModelFromJson(String str) => ServiceListModel.fromJson(json.decode(str));

String serviceListModelToJson(ServiceListModel data) => json.encode(data.toJson());

class ServiceListModel {
  String response;
  List<ServiceList> serviceList;
  int status;

  ServiceListModel({
    required this.response,
    required this.serviceList,
    required this.status,
  });

  factory ServiceListModel.fromJson(Map<String, dynamic> json) => ServiceListModel(
    response: json["response"],
    serviceList: List<ServiceList>.from(json["serviceList"].map((x) => ServiceList.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "serviceList": List<dynamic>.from(serviceList.map((x) => x.toJson())),
    "status": status,
  };
}

class ServiceList {
  String serviceId;
  String artistId;
  String categoryId;
  String? subcategoryId;
  String serviceName;
  String subcategoryName;
  String price;
  String place;
  String description;
  String about;
  List<ServiceImage>? serviceImage;
  List<ServiceVideo>? serviceVideo;

  ServiceList({
    required this.serviceId,
    required this.artistId,
    required this.categoryId,
    required this.subcategoryId,
    required this.serviceName,
    required this.subcategoryName,
    required this.price,
    required this.place,
    required this.description,
    required this.about,
    this.serviceImage,
    this.serviceVideo,
  });

  factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
    serviceId: json["service_id"],
    artistId: json["artist_id"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    serviceName: json["service_name"],
    subcategoryName: json["subcategory_name"],
    price: json["price"],
    place: json["place"],
    description: json["description"],
    about: json["about"],
    serviceImage: json["serviceImage"] == null ? [] : List<ServiceImage>.from(json["serviceImage"]!.map((x) => ServiceImage.fromJson(x))),
    serviceVideo: json["serviceVideo"] == null ? [] : List<ServiceVideo>.from(json["serviceVideo"]!.map((x) => ServiceVideo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "service_id": serviceId,
    "artist_id": artistId,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "service_name": serviceName,
    'subcategory_name':subcategoryName,
    "price": price,
    "place": place,
    "description": description,
    "about": about,
    "serviceImage": serviceImage == null ? [] : List<dynamic>.from(serviceImage!.map((x) => x.toJson())),
    "serviceVideo": serviceVideo == null ? [] : List<dynamic>.from(serviceVideo!.map((x) => x.toJson())),
  };
}

class ServiceImage {
  String photo;

  ServiceImage({
    required this.photo,
  });

  factory ServiceImage.fromJson(Map<String, dynamic> json) => ServiceImage(
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
  };
}

class ServiceVideo {
  String video;

  ServiceVideo({
    required this.video,
  });

  factory ServiceVideo.fromJson(Map<String, dynamic> json) => ServiceVideo(
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "video": video,
  };
}
