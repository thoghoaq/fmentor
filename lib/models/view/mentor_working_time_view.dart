import 'package:flutter/material.dart';

class MentorWorkingTime {
  final int mentorId;
  final String dayOfWeek;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  MentorWorkingTime({
    required this.mentorId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  factory MentorWorkingTime.fromJson(Map<String, dynamic> json) {
    return MentorWorkingTime(
      mentorId: json['mentorId'],
      dayOfWeek: json['dayOfWeek'],
      startTime: TimeOfDay.fromDateTime(
          DateTime.parse("2022-02-27 " + json['startTime'])),
      endTime: TimeOfDay.fromDateTime(
          DateTime.parse("2022-02-27 " + json['endTime'])),
    );
  }
}
