class get_question_model {
  String? success;
  String? status;
  String? message;
  List<Data>? data;

  get_question_model({this.success, this.status, this.message, this.data});

  get_question_model.fromJson(Map<String, dynamic> json) {
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
  String? title;
  List<Options>? options;
  String? isAnswered;
  String? answeredId;

  Data({this.id, this.title, this.options, this.isAnswered, this.answeredId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
    isAnswered = json['is_answered'];
    answeredId = json['answered_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    data['is_answered'] = this.isAnswered;
    data['answered_id'] = this.answeredId;
    return data;
  }
}

class Options {
  String? id;
  String? title;
  String? score;

  Options({this.id, this.title, this.score});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['score'] = this.score;
    return data;
  }
}
