import 'package:mentoo/models/metor.dart';

class AppointmentViewModel {
  final int appointmentId;
  final int mentorId;
  final int menteeId;
  final DateTime startTime;
  final DateTime endTime;
  final String googleMeetLink;
  final int duration;
  final String status;
  final String note;
  final Mentor mentor;

  AppointmentViewModel({
    required this.appointmentId,
    required this.mentorId,
    required this.menteeId,
    required this.startTime,
    required this.endTime,
    required this.googleMeetLink,
    required this.duration,
    required this.status,
    required this.note,
    required this.mentor,
  });

  factory AppointmentViewModel.fromJson(Map<String, dynamic> json) {
    return AppointmentViewModel(
      appointmentId: json['appointmentId'],
      mentorId: json['mentorId'],
      menteeId: json['menteeId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      googleMeetLink: json['googleMeetLink'],
      duration: json['duration'].toInt(),
      status: json['status'],
      note: json['note'],
      mentor: Mentor.fromJson(json['mentor']),
    );
  }
}
