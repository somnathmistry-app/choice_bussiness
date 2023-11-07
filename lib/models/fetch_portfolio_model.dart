// To parse this JSON data, do
//
//     final fetchPortfolioModel = fetchPortfolioModelFromJson(jsonString);

import 'dart:convert';

FetchPortfolioModel fetchPortfolioModelFromJson(String str) => FetchPortfolioModel.fromJson(json.decode(str));

String fetchPortfolioModelToJson(FetchPortfolioModel data) => json.encode(data.toJson());

class FetchPortfolioModel {
  String response;
  List<ArtistPortfolio> artistPortfolio;
  int status;

  FetchPortfolioModel({
    required this.response,
    required this.artistPortfolio,
    required this.status,
  });

  factory FetchPortfolioModel.fromJson(Map<String, dynamic> json) => FetchPortfolioModel(
    response: json["response"],
    artistPortfolio: List<ArtistPortfolio>.from(json["artistPortfolio"].map((x) => ArtistPortfolio.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "artistPortfolio": List<dynamic>.from(artistPortfolio.map((x) => x.toJson())),
    "status": status,
  };
}

class ArtistPortfolio {
  String businessName;
  String phoneNumber;
  String categoryId;
  dynamic location;
  dynamic profilePhoto;
  String description;
  dynamic facebookLink;
  dynamic instagramLink;
  List<PortfolioImage> portfolioImage;
  List<PortfolioVideo> portfolioVideo;

  ArtistPortfolio({
    required this.businessName,
    required this.phoneNumber,
    required this.categoryId,
    required this.location,
    required this.profilePhoto,
    required this.description,
    required this.facebookLink,
    required this.instagramLink,
    required this.portfolioImage,
    required this.portfolioVideo,
  });

  factory ArtistPortfolio.fromJson(Map<String, dynamic> json) => ArtistPortfolio(
    businessName: json["business_name"],
    phoneNumber: json["phone_number"],
    categoryId: json["category_id"],
    location: json["location"],
    profilePhoto: json["profile_photo"],
    description: json["description"],
    facebookLink: json["facebook_link"],
    instagramLink: json["instagram_link"],
    portfolioImage: List<PortfolioImage>.from(json["portfolioImage"].map((x) => PortfolioImage.fromJson(x))),
    portfolioVideo: List<PortfolioVideo>.from(json["portfolioVideo"].map((x) => PortfolioVideo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "business_name": businessName,
    "phone_number": phoneNumber,
    "category_id": categoryId,
    "location": location,
    "profile_photo": profilePhoto,
    "description": description,
    "facebook_link": facebookLink,
    "instagram_link": instagramLink,
    "portfolioImage": List<dynamic>.from(portfolioImage.map((x) => x.toJson())),
    "portfolioVideo": List<dynamic>.from(portfolioVideo.map((x) => x.toJson())),
  };
}

class PortfolioImage {
  String photo;

  PortfolioImage({
    required this.photo,
  });

  factory PortfolioImage.fromJson(Map<String, dynamic> json) => PortfolioImage(
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "photo": photo,
  };
}

class PortfolioVideo {
  String video;

  PortfolioVideo({
    required this.video,
  });

  factory PortfolioVideo.fromJson(Map<String, dynamic> json) => PortfolioVideo(
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "video": video,
  };
}
