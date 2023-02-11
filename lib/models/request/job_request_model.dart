// To parse this JSON data, do
//
//     final jobRequestModel = jobRequestModelFromJson(jsonString);

import 'dart:convert';

String jobRequestModelToJson(JobRequestModel data) =>
    json.encode(data.toJson());

class JobRequestModel {
  JobRequestModel({
    required this.userId,
    required this.company,
    required this.role,
    required this.startDate,
    this.endDate,
    required this.isCurrent,
  });

  int userId;
  String company;
  String role;
  DateTime startDate;
  DateTime? endDate;
  bool isCurrent;

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "company": company,
        "role": role,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate == null ? null : endDate!.toIso8601String(),
        "isCurrent": isCurrent,
      };
}
