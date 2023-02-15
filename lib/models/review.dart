// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  Review({
    required this.reviewId,
    required this.appointmentId,
    required this.reviewerId,
    required this.revieweeId,
    required this.rating,
    required this.comment,
  });

  int reviewId;
  int appointmentId;
  int reviewerId;
  int revieweeId;
  int rating;
  String comment;

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
