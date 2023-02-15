// To parse this JSON data, do
//
//     final educationRequestModel = educationRequestModelFromJson(jsonString);

import 'dart:convert';

String educationRequestModelToJson(EducationRequestModel data) =>
    json.encode(data.toJson());

class EducationRequestModel {
  EducationRequestModel({
    required this.userId,
    required this.school,
    required this.major,
    required this.startDate,
    this.endDate,
    required this.isCurrent,
  });

  int userId;
  String school;
  String major;
  DateTime startDate;
  DateTime? endDate;
  bool isCurrent;

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "school": school,
        "major": major,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate == null ? null : endDate!.toIso8601String(),
        "isCurrent": isCurrent,
      };
}
