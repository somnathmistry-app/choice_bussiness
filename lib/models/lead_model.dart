import 'dart:convert';

LeadModel leadModelFromJson(String str) => LeadModel.fromJson(json.decode(str));

String leadModelToJson(LeadModel data) => json.encode(data.toJson());

class LeadModel {
  String? response;
  String? message;
  List<LeadList>? data;

  LeadModel({
    this.response,
    this.message,
    this.data,
  });

  factory LeadModel.fromJson(Map<String, dynamic> json) => LeadModel(
    response: json["response"],
    message: json["message"],
    data: json["data"] == null ? [] : List<LeadList>.from(json["data"]!.map((x) => LeadList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class LeadList {
  String? id;
  String? name;
  String? phone;
  dynamic email;
  dynamic emailVerifiedAt;
  dynamic location;
  String? password;
  String? photo;
  dynamic fcm;
  dynamic bankDetails;
  dynamic bonusAmount;
  String? role;
  dynamic provider;
  dynamic providerId;
  String? status;
  dynamic rememberToken;
  DateTime? createdAt;
  dynamic updatedAt;
  String? leadType;
  String? artistId;
  String? categoryId;
  String? subcategoryId;
  String? serviceName;
  String? price;
  String? place;
  String? description;
  String? about;

  LeadList({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.emailVerifiedAt,
    this.location,
    this.password,
    this.photo,
    this.fcm,
    this.bankDetails,
    this.bonusAmount,
    this.role,
    this.provider,
    this.providerId,
    this.status,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.leadType,
    this.artistId,
    this.categoryId,
    this.subcategoryId,
    this.serviceName,
    this.price,
    this.place,
    this.description,
    this.about,
  });

  factory LeadList.fromJson(Map<String, dynamic> json) => LeadList(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    location: json["location"],
    password: json["password"],
    photo: json["photo"],
    fcm: json["fcm"],
    bankDetails: json["bank_details"],
    bonusAmount: json["bonus_amount"],
    role: json["role"],
    provider: json["provider"],
    providerId: json["provider_id"],
    status: json["status"],
    rememberToken: json["remember_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    leadType: json["lead_type"],
    artistId: json["artist_id"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    serviceName: json["service_name"],
    price: json["price"],
    place: json["place"],
    description: json["description"],
    about: json["about"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "location": location,
    "password": password,
    "photo": photo,
    "fcm": fcm,
    "bank_details": bankDetails,
    "bonus_amount": bonusAmount,
    "role": role,
    "provider": provider,
    "provider_id": providerId,
    "status": status,
    "remember_token": rememberToken,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt,
    "lead_type": leadType,
    "artist_id": artistId,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "service_name": serviceName,
    "price": price,
    "place": place,
    "description": description,
    "about": about,
  };
}
