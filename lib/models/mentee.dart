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
        menteeId: json["menteeId"],
        userId: json["userId"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "menteeId": menteeId,
        "userId": userId,
        "user": user.toJson(),
      };
}
