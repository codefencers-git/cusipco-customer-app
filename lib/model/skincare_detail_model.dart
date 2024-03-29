// To parse this JSON data, do
//
//     final skincareDetailsModel = skincareDetailsModelFromJson(jsonString);

import 'dart:convert';

SkincareDetailsModel skincareDetailsModelFromJson(String str) =>
    SkincareDetailsModel.fromJson(json.decode(str));

String skincareDetailsModelToJson(SkincareDetailsModel data) =>
    json.encode(data.toJson());

class SkincareDetailsModel {
  SkincareDetailsModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  String success;
  String status;
  String message;
  Data data;

  factory SkincareDetailsModel.fromJson(Map<String, dynamic> json) =>
      SkincareDetailsModel(
        success: json["success"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.image,
    required this.title,
    required this.owner,
    required this.price,
    required this.rating,
    required this.description,
    required this.ownerId,
    this.salePrice,
    // required this.timing,
    required this.vendors,
    this.tax,
    required this.payableAmount,
  });

  String id;
  List<String> image;
  String title;
  String owner;
  String ownerId;
  String price;
  String? salePrice;
  String rating;
  String? tax;
  String payableAmount;
  String description;
  // List<Timing> timing;
  List<Vendors> vendors;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        image: List<String>.from(json["image"].map((x) => x)),
        title: json["title"],
        owner: json["owner"],
        payableAmount: json["payable_amount"],
        tax: json["tax"],
        ownerId: json["owner_id"],
        price: json["price"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
        rating: json["rating"],
        description: json["description"],
        // timing:
        //     List<Timing>.from(json["timing"].map((x) => Timing.fromJson(x))),
    vendors:
        List<Vendors>.from(json["vendors"].map((x) => Vendors.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": List<dynamic>.from(image.map((x) => x)),
        "title": title,
        "payable_amount": payableAmount,
        "tax": tax,
        "owner": owner,
        "price": price,
        "owner_id": ownerId,
        "rating": rating,
        "sale_price": salePrice == null ? null : salePrice,
        "description": description,
    // "timing": List<dynamic>.from(timing.map((x) => x.toJson())),
    "vendors": List<dynamic>.from(vendors.map((x) => x.toJson())),
      };
}

class Vendors {
  String? id;
  String? name;
  String? profileImage;
  String? address;

  Vendors({this.id, this.name, this.profileImage, this.address});

  Vendors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['address'] = this.address;
    return data;
  }
}

class Timing {
  Timing({
    required this.slug,
    required this.title,
  });

  String slug;
  String title;

  factory Timing.fromJson(Map<String, dynamic> json) => Timing(
    slug: json["slug"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "title": title,
  };
}