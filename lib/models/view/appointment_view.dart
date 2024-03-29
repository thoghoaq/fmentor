import 'package:mentoo/models/mentee.dart';
import 'package:mentoo/models/mentor.dart';

class AppointmentViewModel {
  final int appointmentId;
  final int mentorId;
  final int menteeId;
  final DateTime startTime;
  final DateTime endTime;
  final String googleMeetLink;
  final String password;
  final int duration;
  final String status;
  final String note;
  final bool isReviewed;
  final Mentor? mentor;
  final Mentee? mentee;

  AppointmentViewModel({
    required this.appointmentId,
    required this.mentorId,
    required this.menteeId,
    required this.startTime,
    required this.endTime,
    required this.googleMeetLink,
    required this.password,
    required this.duration,
    required this.status,
    required this.note,
    required this.isReviewed,
    this.mentor,
    this.mentee,
  });

  factory AppointmentViewModel.fromJson(Map<String, dynamic> json) {
    return AppointmentViewModel(
      appointmentId: json['appointmentId'],
      mentorId: json['mentorId'],
      menteeId: json['menteeId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      googleMeetLink: json['googleMeetLink'],
      password: json['password'],
      duration: json['duration'].toInt(),
      status: json['status'],
      note: json['note'] ?? "",
      isReviewed: json['isReviewed'],
      mentor: json['mentor'] != null ? Mentor.fromJson(json['mentor']) : null,
      mentee: json['mentee'] != null ? Mentee.fromJson(json['mentee']) : null,
    );
  }
}
