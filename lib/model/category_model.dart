// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  String? success;
  String? status;
  String? message;
  List<CategoryData>? data;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        success: json["success"] == null ? null : json["success"],
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<CategoryData>.from(
                json["data"].map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoryData {
  CategoryData({
    this.id,
    this.title,
    this.image,
    this.isLocal,
    this.status,
  });

  String? id;
  String? title;
  String? image;
  bool? isLocal;
  String? status;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        isLocal: json["isLocal"] == false ? false : json["isLocal"],
        image: json["image"] == null ? null : json["image"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "image": image == null ? null : image,
        "isLocal": isLocal == false ? false : isLocal,
        "status": status == null ? null : status,
      };
}
