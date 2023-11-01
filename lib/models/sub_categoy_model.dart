// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

SubCategoryModel subCategoryModelFromJson(String str) => SubCategoryModel.fromJson(json.decode(str));

String subCategoryModelToJson(SubCategoryModel data) => json.encode(data.toJson());

class SubCategoryModel {
  String response;
  List<Subcat> catsubcat;
  int status;

  SubCategoryModel({
    required this.response,
    required this.catsubcat,
    required this.status,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    response: json["response"],
    catsubcat: List<Subcat>.from(json["catsubcat"].map((x) => Subcat.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "catsubcat": List<dynamic>.from(catsubcat.map((x) => x.toJson())),
    "status": status,
  };
}

class Subcat {
  String id;
  String title;
  String slug;
  dynamic summary;
  String? photo;
  String isParent;
  String? parentId;
  List<Subcat>? subcat;

  Subcat({
    required this.id,
    required this.title,
    required this.slug,
    required this.summary,
    this.photo,
    required this.isParent,
    required this.parentId,
    this.subcat,
  });

  factory Subcat.fromJson(Map<String, dynamic> json) => Subcat(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    summary: json["summary"],
    photo: json["photo"],
    isParent: json["is_parent"],
    parentId: json["parent_id"],
    subcat: json["subcat"] == null ? [] : List<Subcat>.from(json["subcat"]!.map((x) => Subcat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "summary": summary,
    "photo": photo,
    "is_parent": isParent,
    "parent_id": parentId,
    "subcat": subcat == null ? [] : List<dynamic>.from(subcat!.map((x) => x.toJson())),
  };
}
