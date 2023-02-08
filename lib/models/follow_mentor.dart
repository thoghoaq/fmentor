// To parse this JSON data, do
//
//     final followMentor = followMentorFromJson(jsonString);

import 'dart:convert';

FollowMentor followMentorFromJson(String str) =>
    FollowMentor.fromJson(json.decode(str));

String followMentorToJson(FollowMentor data) => json.encode(data.toJson());

class FollowMentor {
  FollowMentor({
    required this.mentorId,
    required this.menteeId,
    required this.isFollow,
  });

  int mentorId;
  int menteeId;
  bool isFollow;

  factory FollowMentor.fromJson(Map<String, dynamic> json) => FollowMentor(
        mentorId: json["mentorId"],
        menteeId: json["menteeId"],
        isFollow: json["isFollow"],
      );

  Map<String, dynamic> toJson() => {
        "mentorId": mentorId,
        "menteeId": menteeId,
        "isFollow": isFollow,
      };
}
