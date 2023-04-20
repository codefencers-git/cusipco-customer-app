class NewCategoryModel {
  String? success;
  String? status;
  String? message;
  Data? data;

  NewCategoryModel({this.success, this.status, this.message, this.data});

  NewCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  List<String>? image;
  String? title;
  String? owner;
  String? ownerId;
  String? price;
  String? salePrice;
  String? tax;
  String? payableAmount;
  String? rating;
  String? description;
  List<Timing>? timing;

  Data(
      {this.id,
        this.image,
        this.title,
        this.owner,
        this.ownerId,
        this.price,
        this.salePrice,
        this.tax,
        this.payableAmount,
        this.rating,
        this.description,
        this.timing
      });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'].cast<String>();
    title = json['title'];
    owner = json['owner'];
    ownerId = json['owner_id'];
    price = json['price'];
    salePrice = json['sale_price'];
    tax = json['tax'];
    payableAmount = json['payable_amount'];
    rating = json['rating'];
    description = json['description'];
    if (json['timing'] != null) {
      timing = <Timing>[];
      json['timing'].forEach((v) {
        timing!.add(new Timing.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['owner'] = this.owner;
    data['owner_id'] = this.ownerId;
    data['price'] = this.price;
    data['sale_price'] = this.salePrice;
    data['tax'] = this.tax;
    data['payable_amount'] = this.payableAmount;
    data['rating'] = this.rating;
    data['description'] = this.description;
    // if (this.timing != null) {
    //   data['timing'] = this.timing!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Timing {
  String? slug;
  String? title;

  Timing({this.slug, this.title});

  Timing.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['title'] = this.title;
    return data;
  }
}
