// To parse this JSON data, do
//
//     final mentor = mentorFromJson(jsonString);

import 'dart:convert';

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
  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.isMentor,
    required this.age,
    required this.description,
    required this.videoIntroduction,
  });

  int userId;
  String name;
  String email;
  String password;
  int isMentor;
  int age;
  String description;
  String videoIntroduction;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        isMentor: json["isMentor"],
        age: json["age"],
        description: json["description"],
        videoIntroduction: json["videoIntroduction"],
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
      };
}
