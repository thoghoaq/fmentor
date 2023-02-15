// To parse this JSON data, do
//
//     final favoriteCourse = favoriteCourseFromJson(jsonString);

import 'dart:convert';

FavoriteCourse favoriteCourseFromJson(String str) =>
    FavoriteCourse.fromJson(json.decode(str));

String favoriteCourseToJson(FavoriteCourse data) => json.encode(data.toJson());

class FavoriteCourse {
  FavoriteCourse({
    required this.menteeId,
    required this.courseId,
    required this.isFavorite,
  });

  int menteeId;
  int courseId;
  bool isFavorite;

  factory FavoriteCourse.fromJson(Map<String, dynamic> json) => FavoriteCourse(
        menteeId: json["menteeId"],
        courseId: json["courseId"],
        isFavorite: json["isFavorite"],
      );

  Map<String, dynamic> toJson() => {
        "menteeId": menteeId,
        "courseId": courseId,
        "isFavorite": isFavorite,
      };
}
