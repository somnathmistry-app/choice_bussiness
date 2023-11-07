// To parse this JSON data, do
//
//     final savePortfolioModel = savePortfolioModelFromJson(jsonString);

import 'dart:convert';

SavePortfolioModel savePortfolioModelFromJson(String str) => SavePortfolioModel.fromJson(json.decode(str));

String savePortfolioModelToJson(SavePortfolioModel data) => json.encode(data.toJson());

class SavePortfolioModel {
  String response;
  String message;
  List<ArtistDetail> artistDetail;
  int status;

  SavePortfolioModel({
    required this.response,
    required this.message,
    required this.artistDetail,
    required this.status,
  });

  factory SavePortfolioModel.fromJson(Map<String, dynamic> json) => SavePortfolioModel(
    response: json["response"],
    message: json["message"],
    artistDetail: List<ArtistDetail>.from(json["artistDetail"].map((x) => ArtistDetail.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "artistDetail": List<dynamic>.from(artistDetail.map((x) => x.toJson())),
    "status": status,
  };
}

class ArtistDetail {
  String businessName;
  String phoneNumber;
  String categoryId;
  String location;
  dynamic profilePhoto;
  String description;
  dynamic facebookLink;
  dynamic instagramLink;
  List<PortfolioImage> portfolioImage;
  List<PortfolioVideo> portfolioVideo;

  ArtistDetail({
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

  factory ArtistDetail.fromJson(Map<String, dynamic> json) => ArtistDetail(
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
