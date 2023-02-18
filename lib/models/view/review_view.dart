// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<ReviewView> reviewFromJson(String str) =>
    List<ReviewView>.from(json.decode(str).map((x) => ReviewView.fromJson(x)));

String reviewToJson(List<ReviewView> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReviewView {
  ReviewView({
    required this.reviewId,
    required this.appointmentId,
    required this.reviewerId,
    required this.revieweeId,
    required this.rating,
    required this.comment,
    required this.reviewer,
  });

  int reviewId;
  int appointmentId;
  int reviewerId;
  int revieweeId;
  int rating;
  String comment;
  Reviewer reviewer;

  factory ReviewView.fromJson(Map<String, dynamic> json) => ReviewView(
        reviewId: json["reviewId"],
        appointmentId: json["appointmentId"],
        reviewerId: json["reviewerId"],
        revieweeId: json["revieweeId"],
        rating: json["rating"],
        comment: json["comment"],
        reviewer: Reviewer.fromJson(json['reviewer']),
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

class Reviewer {
  Reviewer({
    required this.name,
    required this.photo,
  });
  String name;
  String photo;

  factory Reviewer.fromJson(Map<String, dynamic> json) => Reviewer(
        name: json["name"],
        photo: json["photo"],
      );
}
