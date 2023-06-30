class BlogListingModel {
  String? success;
  String? status;
  String? message;
  List<Data>? data;

  BlogListingModel({this.success, this.status, this.message, this.data});

  BlogListingModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? image;
  String? title;
  String? description;
  String? short_description;
  String? author;
  String? date;

  Data({this.id, this.image, this.title, this.description, this.short_description, this.author, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    date = json['date'];
    author = json['author'];
    title = json['title'];
    short_description = json['short_description'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['author'] = this.author;
    data['date'] = this.date;
    data['title'] = this.title;
    data['description'] = this.description;
    data['short_description'] = this.short_description;
    return data;
  }
}