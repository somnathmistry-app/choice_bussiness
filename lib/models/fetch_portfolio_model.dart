// To parse this JSON data, do
//
//     final fetchPortfolioModel = fetchPortfolioModelFromJson(jsonString);

import 'dart:convert';

FetchPortfolioModel fetchPortfolioModelFromJson(String str) => FetchPortfolioModel.fromJson(json.decode(str));

String fetchPortfolioModelToJson(FetchPortfolioModel data) => json.encode(data.toJson());

class FetchPortfolioModel {
  String response;
  FetchPortfolioModelArtistPortfolio artistPortfolio;
  int status;

  FetchPortfolioModel({
    required this.response,
    required this.artistPortfolio,
    required this.status,
  });

  factory FetchPortfolioModel.fromJson(Map<String, dynamic> json) => FetchPortfolioModel(
    response: json["response"],
    artistPortfolio: FetchPortfolioModelArtistPortfolio.fromJson(json["artistPortfolio"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "artistPortfolio": artistPortfolio.toJson(),
    "status": status,
  };
}

class FetchPortfolioModelArtistPortfolio {
  String phoneNumber;
  String emailId;
  List<ArtistPortfolioElement> artistPortfolio;

  FetchPortfolioModelArtistPortfolio({
    required this.phoneNumber,
    required this.emailId,
    required this.artistPortfolio,
  });

  factory FetchPortfolioModelArtistPortfolio.fromJson(Map<String, dynamic> json) => FetchPortfolioModelArtistPortfolio(
    phoneNumber: json["phone_number"],
    emailId: json["email_id"],
    artistPortfolio: List<ArtistPortfolioElement>.from(json["artistPortfolio"].map((x) => ArtistPortfolioElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "phone_number": phoneNumber,
    "email_id": emailId,
    "artistPortfolio": List<dynamic>.from(artistPortfolio.map((x) => x.toJson())),
  };
}

class ArtistPortfolioElement {
  String image;
  String video;
  String facebookLink;
  String instagramLink;

  ArtistPortfolioElement({
    required this.image,
    required this.video,
    required this.facebookLink,
    required this.instagramLink,
  });

  factory ArtistPortfolioElement.fromJson(Map<String, dynamic> json) => ArtistPortfolioElement(
    image: json["image"],
    video: json["video"],
    facebookLink: json["facebook_link"],
    instagramLink: json["instagram_link"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "video": video,
    "facebook_link": facebookLink,
    "instagram_link": instagramLink,
  };
}
