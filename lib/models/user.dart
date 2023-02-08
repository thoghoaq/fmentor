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
    required this.photo,
    this.jobs,
    this.educations,
    required this.mentees,
    this.mentors,
    this.payments,
    this.reviewees,
    this.reviewers,
    this.userspecialties,
    this.isMentorNavigation,
    this.wallet,
  });

  int userId;
  String name;
  String email;
  String password;
  int isMentor;
  int age;
  String description;
  String videoIntroduction;
  String photo;
  List<Job>? jobs;
  List<Education>? educations;
  List<Mentee> mentees;
  List<Mentor>? mentors;
  List<Payment>? payments;
  List<Review>? reviewees;
  List<Review>? reviewers;
  List<UserSpecialties>? userspecialties;
  UserPermission? isMentorNavigation;
  Wallet? wallet;

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
        jobs: json["jobs"] != null
            ? List<Job>.from(json["jobs"].map((x) => Job.fromJson(x)))
            : null,
        educations: json["educations"] != null
            ? List<Education>.from(
                json["educations"].map((x) => Education.fromJson(x)))
            : null,
        isMentorNavigation: UserPermission.fromJson(json["isMentorNavigation"]),
        mentees:
            List<Mentee>.from(json["mentees"].map((x) => Mentee.fromJson(x))),
        mentors: json["mentors"] != null
            ? List<Mentor>.from(json["mentors"].map((x) => Mentor.fromJson(x)))
            : null,
        payments: json["payments"] != null
            ? List<Payment>.from(
                json["payments"].map((x) => Payment.fromJson(x)))
            : null,
        reviewees: json["reviewees"] != null
            ? List<Review>.from(
                json["reviewees"].map((x) => Review.fromJson(x)))
            : null,
        reviewers: json["reviewers"] != null
            ? List<Review>.from(
                json["reviewers"].map((x) => Review.fromJson(x)))
            : null,
        userspecialties: json["userspecialties"] != null
            ? List<UserSpecialties>.from(
                json["userspecialties"].map((x) => UserSpecialties.fromJson(x)))
            : null,
        wallet: json["wallet"] != null ? Wallet.fromJson(json["wallet"]) : null,
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
        "jobs": jobs == null
            ? List<dynamic>.from(jobs!.map((x) => x.toJson()))
            : null,
        "educations": educations != null
            ? List<dynamic>.from(educations!.map((x) => x.toJson()))
            : null,
        "isMentorNavigation":
            isMentorNavigation != null ? isMentorNavigation!.toJson() : null,
        "mentees": List<dynamic>.from(mentees.map((x) => x.toJson())),
        "mentors": mentors != null
            ? List<dynamic>.from(mentors!.map((x) => x.toJson()))
            : null,
        "payments": payments != null
            ? List<dynamic>.from(payments!.map((x) => x.toJson()))
            : null,
        "reviewees": reviewees != null
            ? List<dynamic>.from(reviewees!.map((x) => x.toJson()))
            : null,
        "reviewers": reviewers != null
            ? List<dynamic>.from(reviewers!.map((x) => x.toJson()))
            : null,
        "userspecialties": userspecialties != null
            ? List<dynamic>.from(userspecialties!.map((x) => x.toJson()))
            : null,
        "wallet": wallet != null ? wallet!.toJson() : null,
      };
}

class Education {
  Education({
    required this.educationId,
    required this.userId,
    required this.school,
    required this.major,
    required this.startDate,
    this.endDate,
    required this.isCurrent,
  });

  int educationId;
  int userId;
  String school;
  String major;
  DateTime startDate;
  DateTime? endDate;
  int isCurrent;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        educationId: json["educationId"],
        userId: json["userId"],
        school: json["school"],
        major: json["major"],
        startDate: DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        isCurrent: json["isCurrent"],
      );

  Map<String, dynamic> toJson() => {
        "educationId": educationId,
        "userId": userId,
        "school": school,
        "major": major,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
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
    this.endDate,
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
            json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
        isCurrent: json["isCurrent"],
      );

  Map<String, dynamic> toJson() => {
        "jobId": jobId,
        "userId": userId,
        "company": company,
        "role": role,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate!.toIso8601String(),
        "isCurrent": isCurrent,
      };
}

class Mentee {
  Mentee({
    required this.menteeId,
    required this.userId,
  });

  int menteeId;
  int userId;

  factory Mentee.fromJson(Map<String, dynamic> json) => Mentee(
        menteeId: json["menteeId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "menteeId": menteeId,
        "userId": userId,
      };
}

class Mentor {
  Mentor({
    required this.mentorId,
    required this.userId,
    required this.specialty,
    required this.hourlyRate,
    required this.availability,
    required this.numberFollower,
    required this.numberMentee,
  });

  int mentorId;
  int userId;
  String specialty;
  double hourlyRate;
  int availability;
  int numberFollower;
  int numberMentee;

  factory Mentor.fromJson(Map<String, dynamic> json) => Mentor(
        mentorId: json["mentorId"],
        userId: json["userId"],
        specialty: json["specialty"],
        hourlyRate: json["hourlyRate"],
        availability: json["availability"],
        numberFollower: json["numberFollower"],
        numberMentee: json["numberMentee"],
      );

  Map<String, dynamic> toJson() => {
        "mentorId": mentorId,
        "userId": userId,
        "specialty": specialty,
        "hourlyRate": hourlyRate,
        "availability": availability,
        "numberFollower": numberFollower,
        "numberMentee": numberMentee,
      };
}

class Payment {
  int paymentId;
  int userId;
  double amount;
  DateTime paymentDate;
  String? note;

  Payment({
    required this.paymentId,
    required this.userId,
    required this.amount,
    required this.paymentDate,
    required this.note,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentId: json["paymentId"],
        userId: json["userId"],
        amount: json["amount"],
        paymentDate: json["paymentDate"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "paymentId": paymentId,
        "userId": userId,
        "amount": amount,
        "note": note,
        "paymentDate": paymentDate,
      };
}

class Review {
  int reviewId;
  int appointmentId;
  int reviewerId;
  int revieweeId;
  int rating;
  String comment;

  Review({
    required this.reviewId,
    required this.appointmentId,
    required this.reviewerId,
    required this.revieweeId,
    required this.rating,
    required this.comment,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        reviewId: json["reviewId"],
        appointmentId: json["appointmentId"],
        reviewerId: json["reviewerId"],
        revieweeId: json["revieweeId"],
        rating: json["rating"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "reviewId": reviewId,
        "appointmentId": appointmentId,
        "reviewerId": reviewerId,
        "revieweeId": revieweeId,
        "rating": rating,
        "comment": comment,
      };
}

class UserSpecialties {
  UserSpecialties({
    required this.specialtyId,
    required this.userSpecialtyId,
    required this.userId,
  });

  int userSpecialtyId;
  int specialtyId;
  int userId;

  factory UserSpecialties.fromJson(Map<String, dynamic> json) =>
      UserSpecialties(
        specialtyId: json["specialtyId"],
        userSpecialtyId: json["userSpecialtyId"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "specialtyId": specialtyId,
        "userSpecialtyId": userSpecialtyId,
        "userId": userId,
      };
}

class UserPermission {
  int isMentor;
  int canSeeSettings;
  int canSeePolicy;
  int canLogout;
  int canFollowMentors;
  int canRequestToMentor;
  int canMakeSchedule;
  int canSeeCourses;

  UserPermission({
    required this.isMentor,
    required this.canSeeSettings,
    required this.canSeePolicy,
    required this.canLogout,
    required this.canFollowMentors,
    required this.canRequestToMentor,
    required this.canMakeSchedule,
    required this.canSeeCourses,
  });

  factory UserPermission.fromJson(dynamic json) {
    return UserPermission(
      isMentor: json['isMentor'],
      canSeeSettings: json['canSeeSettings'],
      canSeePolicy: json['canSeePolicy'],
      canLogout: json['canLogout'],
      canFollowMentors: json['canFollowMentors'],
      canRequestToMentor: json['canRequestToMentor'],
      canMakeSchedule: json['canMakeSchedule'],
      canSeeCourses: json['canSeeCourses'],
    );
  }

  Map<String, dynamic> toJson() => {
        "isMentor": isMentor,
        "canSeeSettings": canSeeSettings,
        "canSeePolicy": canSeePolicy,
        "canLogout": canLogout,
        "canFollowMentors": canFollowMentors,
        "canRequestToMentor": canRequestToMentor,
        "canMakeSchedule": canMakeSchedule,
        "canSeeCourses": canSeeCourses,
      };
}

class Wallet {
  Wallet({
    required this.balance,
    required this.userId,
  });

  double balance;
  int userId;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        balance: json["balance"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "userId": userId,
      };
}
