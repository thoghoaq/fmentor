import 'package:mentoo/models/user.dart';

class Mentee {
  Mentee({
    required this.menteeId,
    required this.userId,
    required this.user,
  });

  int menteeId;
  int userId;
  User user;

  factory Mentee.fromJson(Map<String, dynamic> json) => Mentee(
        menteeId: json["mentorId"],
        userId: json["userId"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "menteeId": menteeId,
        "userId": userId,
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
      required this.jobs,
      required this.educations});

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
      photo: json["photo"],
      jobs: List<Job>.from(json["jobs"].map((x) => Job.fromJson(x))),
      educations: List<Education>.from(
          json["educations"].map((x) => Education.fromJson(x))));

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
        "educations": List<dynamic>.from(educations.map((x) => x.toJson())),
      };
}
