// To parse this JSON data, do
//
//     final promotion = promotionFromJson(jsonString);

import 'dart:convert';

Promotion promotionFromJson(String str) => Promotion.fromJson(json.decode(str));

String promotionToJson(Promotion data) => json.encode(data.toJson());

class Promotion {
  Promotion({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  int status;
  String message;
  List<SinglePromotion> data;
  List<dynamic> errors;

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
        status: json["status"],
        message: json["message"],
        data: List<SinglePromotion>.from(
            json["data"].map((x) => SinglePromotion.fromJson(x))),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "errors": List<dynamic>.from(errors.map((x) => x)),
      };
}

class SinglePromotion {
  SinglePromotion({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.imageLink,
  });

  int id;
  String title;
  String description;
  dynamic image;
  DateTime createdAt;
  DateTime updatedAt;
  String imageLink;

  factory SinglePromotion.fromJson(Map<String, dynamic> json) =>
      SinglePromotion(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        imageLink: json["imageLink"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "imageLink": imageLink,
      };
}
