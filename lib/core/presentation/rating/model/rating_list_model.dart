

import 'dart:convert';

RatingListModel ratindListModelFromJson(String str) => RatingListModel.fromJson(json.decode(str));

String ratindListModelToJson(RatingListModel data) => json.encode(data.toJson());

class RatingListModel {
  int ?success;
  String ?message;
  var rating;
  List<ListElement>? list;
  int ?ratingCount;

  RatingListModel({
     this.success,
     this.message,
     this.rating,
     this.list,
    this.ratingCount,
  });

  factory RatingListModel.fromJson(Map<String, dynamic> json) => RatingListModel(
    success: json["success"],
    message: json["message"],
    rating: json["rating"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    ratingCount: json["ratingCount"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "rating": rating,
    "list": List<dynamic>.from(list!.map((x) => x.toJson())),
    "ratingCount": ratingCount,
  };
}

class ListElement {
  int id;
  dynamic name;
  String? driver_profile_pic;
  final String? customerProfilePic;
  String rating;
  var review;
  DateTime createdAt;

  ListElement({
    required this.id,
    required this.name,
     this.driver_profile_pic,
     this.customerProfilePic,
    required this.rating,
    required this.review,
    required this.createdAt,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["id"],
    name: json["name"],
    driver_profile_pic: json["driver_profile_pic"],
    customerProfilePic: json["customer_profile_pic"],
    rating: json["rating"],
    review: json["review"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "driver_profile_pic": driver_profile_pic,
    "rating": rating,
    "customer_profile_pic": customerProfilePic,
    "review": review,
    "created_at": createdAt.toIso8601String(),
  };
}
