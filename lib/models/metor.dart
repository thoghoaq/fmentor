// To parse this JSON data, do
//
//     final mentor = mentorFromJson(jsonString);

import 'dart:convert';

import 'package:mentoo/models/user.dart';

List<Mentor> mentorFromJson(String str) =>
    List<Mentor>.from(json.decode(str).map((x) => Mentor.fromJson(x)));

String mentorToJson(List<Mentor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mentor {
  Mentor({
    required this.mentorId,
    required this.userId,
    required this.specialty,
    required this.hourlyRate,
    required this.availability,
    required this.user,
  });

  int mentorId;
  int userId;
  String specialty;
  double hourlyRate;
  int availability;
  User user;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
        mentorId: json["mentorId"],
        userId: json["userId"],
        specialty: json["specialty"],
        hourlyRate: json["hourlyRate"],
        availability: json["availability"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "mentorId": mentorId,
        "userId": userId,
        "specialty": specialty,
        "hourlyRate": hourlyRate,
        "availability": availability,
        "user": user.toJson(),
      };
}

class User {
  User(
      {required this.userId,
      required this.name,
      required this.email,
      required this.password,
      required this.isMentor,
      required this.age,
      required this.description,
      required this.videoIntroduction,
      required this.photo,
      required this.jobs});

  int userId;
  String name;
  String email;
  String password;
  int isMentor;
  int age;
  String description;
  String videoIntroduction;
  String photo;
  List<Job> jobs;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        isMentor: json["isMentor"],
        age: json["age"],
        description: json["description"],
        videoIntroduction: json["videoIntroduction"],
        photo: json["photo"],
        jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "email": email,
        "password": password,
        "isMentor": isMentor,
        "age": age,
        "description": description,
        "videoIntroduction": videoIntroduction,
        "photo": photo,
        "jobs": List<dynamic>.from(jobs.map((x) => x.toJson())),
      };
}
