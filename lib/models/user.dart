// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    required this.jobs,
    required this.educations,
  });

  int userId;
  String name;
  String email;
  String password;
  int isMentor;
  int age;
  String description;
  String videoIntroduction;
  List<Job> jobs;
  List<Education> educations;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        isMentor: json["isMentor"],
        age: json["age"],
        description: json["description"],
        videoIntroduction: json["videoIntroduction"],
        jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
        educations: List<Education>.from(
            json["educations"].map((x) => Education.fromJson(x))),
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
        "jobs": List<dynamic>.from(jobs.map((x) => x.toJson())),
        "educations": List<dynamic>.from(educations.map((x) => x.toJson())),
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
  });

  int educationId;
  int userId;
  String school;
  String major;
  DateTime startDate;
  DateTime endDate;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        educationId: json["educationId"],
        userId: json["userId"],
        school: json["school"],
        major: json["major"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "educationId": educationId,
        "userId": userId,
        "school": school,
        "major": major,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
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
  });

  int jobId;
  int userId;
  String company;
  String role;
  DateTime startDate;
  DateTime endDate;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        jobId: json["jobId"],
        userId: json["userId"],
        company: json["company"],
        role: json["role"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
      );

  Map<String, dynamic> toJson() => {
        "jobId": jobId,
        "userId": userId,
        "company": company,
        "role": role,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };
}
