// To parse this JSON data, do
//
//     final commonModel = commonModelFromJson(jsonString);

import 'dart:convert';

AgoraTokenModel commonModelFromJson(String str) =>
    AgoraTokenModel.fromJson(json.decode(str));

String commonModelToJson(AgoraTokenModel data) => json.encode(data.toJson());

class AgoraTokenModel {
  AgoraTokenModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  String success;
  String status;
  String message;
  Data data;

  factory AgoraTokenModel.fromJson(Map<String, dynamic> json) =>
      AgoraTokenModel(
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
    required this.call_token,
    required this.call_room,
  });

  String call_token;
  String call_room;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        call_token: json["call_token"],
        call_room: json["call_room"],
      );

  Map<String, dynamic> toJson() => {
        "call_token": call_token,
        "call_room": call_room,
      };
}
