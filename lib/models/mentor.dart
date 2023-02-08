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
    required this.numberFollower,
    required this.numberMentee,
    required this.user,
  });

  int mentorId;
  int userId;
  String specialty;
  double hourlyRate;
  int availability;
  int numberFollower;
  int numberMentee;
  User user;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
        mentorId: json["mentorId"],
        userId: json["userId"],
        specialty: json["specialty"],
        hourlyRate: json["hourlyRate"],
        availability: json["availability"],
        numberFollower: json["numberFollower"],
        numberMentee: json["numberMentee"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "mentorId": mentorId,
        "userId": userId,
        "specialty": specialty,
        "hourlyRate": hourlyRate,
        "availability": availability,
        "numberFollower": numberFollower,
        "numberMentee": numberMentee,
        "user": user.toJson(),
      };
}

class Education {
  Education({
    required this.educationId,
    required this.userId,
    required this.school,
    required this.major,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
  });

  int educationId;
  int userId;
  String school;
  String major;
  DateTime startDate;
  DateTime endDate;
  int isCurrent;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        educationId: json["educationId"],
        userId: json["userId"],
        school: json["school"],
        major: json["major"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        isCurrent: json["isCurrent"],
      );

  Map<String, dynamic> toJson() => {
        "educationId": educationId,
        "userId": userId,
        "school": school,
        "major": major,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "isCurrent": isCurrent,
      };
}

class Job {
  Job({
    required this.jobId,
    required this.userId,
    required this.company,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
  });

  int jobId;
  int userId;
  String company;
  String role;
  DateTime startDate;
  DateTime? endDate;
  int isCurrent;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        jobId: json["jobId"],
        userId: json["userId"],
        company: json["company"],
        role: json["role"],
        startDate: DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]!),
        isCurrent: json["isCurrent"],
      );

  Map<String, dynamic> toJson() => {
        "jobId": jobId,
        "userId": userId,
        "company": company,
        "role": role,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "isCurrent": isCurrent,
      };
}
