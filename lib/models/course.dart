// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

List<Course> courseFromJson(String str) =>
    List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
  Course({
    required this.courseId,
    required this.mentorId,
    required this.title,
    required this.instructor,
    required this.platform,
    required this.link,
    required this.description,
    required this.photo,
  });

  int courseId;
  int mentorId;
  String title;
  String instructor;
  String platform;
  String link;
  String description;
  String photo;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseId: json["courseId"],
        mentorId: json["mentorId"],
        title: json["title"],
        instructor: json["instructor"],
        platform: json["platform"],
        link: json["link"],
        description: json["description"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "courseId": courseId,
        "mentorId": mentorId,
        "title": title,
        "instructor": instructor,
        "platform": platform,
        "link": link,
        "description": description,
        "photo": photo,
      };
}
