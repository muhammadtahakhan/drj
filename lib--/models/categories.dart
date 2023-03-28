// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category? categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category? data) => json.encode(data!.toJson());

class Category {
  Category({
    this.status,
    this.message,
    this.data,
    this.errors,
  });

  int? status;
  String? message;
  List<SingleCategory?>? data;
  List<dynamic>? errors;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<SingleCategory?>.from(
                json["data"]!.map((x) => SingleCategory.fromJson(x))),
        errors: json["errors"] == null
            ? []
            : List<dynamic>.from(json["errors"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x!.toJson())),
        "errors":
            errors == null ? [] : List<dynamic>.from(errors!.map((x) => x)),
      };
}

class SingleCategory {
  SingleCategory(
      {this.id,
      this.parentId,
      this.title,
      this.slug,
      this.icon,
      this.Image,
      this.description,
      this.discount,
      this.createdAt,
      this.updatedAt,
      this.iconLink,
      this.imageLink});

  int? id;
  int? parentId;
  String? title;
  String? slug;
  String? icon;
  String? Image;
  String? description;
  String? discount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? iconLink;
  String? imageLink;

  factory SingleCategory.fromJson(Map<String, dynamic> json) => SingleCategory(
        id: json["id"],
        parentId: int.parse(json["parent_id"]),
        title: json["title"],
        slug: json["slug"],
        icon: json["icon"],
        Image: json["Image"],
        description: json["description"],
        discount: json["discount"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        iconLink: json["iconLink"],
        imageLink: json["imageLink"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "title": title,
        "slug": slug,
        "icon": icon,
        "Image": Image,
        "description": description,
        "discount": discount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "iconLink": iconLink,
        "imageLink": imageLink,
      };
}
