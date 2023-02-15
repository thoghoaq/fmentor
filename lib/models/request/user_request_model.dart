// To parse this JSON data, do
//
//     final userRequestModel = userRequestModelFromJson(jsonString);

import 'dart:convert';

String userRequestModelToJson(UserRequestModel data) =>
    json.encode(data.toJson());

class UserRequestModel {
  UserRequestModel({
    required this.name,
    this.age,
    this.description,
    this.videoIntroduction,
    this.photo,
  });

  String name;
  int? age;
  String? description;
  String? videoIntroduction;
  String? photo;

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age == null ? null : age,
        "description": description == null ? null : description,
        "videoIntroduction":
            videoIntroduction == null ? null : videoIntroduction,
        "photo": photo == null ? null : photo,
      };
}
