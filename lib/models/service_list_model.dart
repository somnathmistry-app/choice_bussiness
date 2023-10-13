// To parse this JSON data, do
//
//     final serviceListModel = serviceListModelFromJson(jsonString);

import 'dart:convert';

ServiceListModel serviceListModelFromJson(String str) => ServiceListModel.fromJson(json.decode(str));

String serviceListModelToJson(ServiceListModel data) => json.encode(data.toJson());

class ServiceListModel {
  String? response;
  List<BookingList>? bookingList;
  int? status;

  ServiceListModel({
    this.response,
    this.bookingList,
    this.status,
  });

  factory ServiceListModel.fromJson(Map<String, dynamic> json) => ServiceListModel(
    response: json["response"],
    bookingList: json["bookingList"] == null ? [] : List<BookingList>.from(json["bookingList"]!.map((x) => BookingList.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "bookingList": bookingList == null ? [] : List<dynamic>.from(bookingList!.map((x) => x.toJson())),
    "status": status,
  };
}

class BookingList {
  String? userid;
  String? username;
  String? userphone;
  String? artistId;
  String? serviceId;
  String? amount;
  List<ServiceList>? serviceList;

  BookingList({
    this.userid,
    this.username,
    this.userphone,
    this.artistId,
    this.serviceId,
    this.amount,
    this.serviceList,
  });

  factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
    userid: json["userid"],
    username: json["username"],
    userphone: json["userphone"],
    artistId: json["artist_id"],
    serviceId: json["service_id"],
    amount: json["amount"],
    serviceList: json["serviceList"] == null ? [] : List<ServiceList>.from(json["serviceList"]!.map((x) => ServiceList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "username": username,
    "userphone": userphone,
    "artist_id": artistId,
    "service_id": serviceId,
    "amount": amount,
    "serviceList": serviceList == null ? [] : List<dynamic>.from(serviceList!.map((x) => x.toJson())),
  };
}

class ServiceList {
  String? serviceId;
  String? artistId;
  String? categoryId;
  String? subcategoryId;
  String? serviceName;
  String? price;
  String? place;

  ServiceList({
    this.serviceId,
    this.artistId,
    this.categoryId,
    this.subcategoryId,
    this.serviceName,
    this.price,
    this.place,
  });

  factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
    serviceId: json["service_id"],
    artistId: json["artist_id"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    serviceName: json["service_name"],
    price: json["price"],
    place: json["place"],
  );

  Map<String, dynamic> toJson() => {
    "service_id": serviceId,
    "artist_id": artistId,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "service_name": serviceName,
    "price": price,
    "place": place,
  };
}
