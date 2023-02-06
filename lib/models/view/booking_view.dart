import 'package:mentoo/models/metor.dart';

class BookingViewModel {
  final int bookingId;
  final int mentorId;
  final int menteeId;
  final DateTime startTime;
  final int duration;
  final double totalCost;
  final String status;
  final String reasonForRejection;
  final Mentor mentor;

  BookingViewModel({
    required this.bookingId,
    required this.mentorId,
    required this.menteeId,
    required this.startTime,
    required this.duration,
    required this.totalCost,
    required this.status,
    required this.reasonForRejection,
    required this.mentor,
  });

  factory BookingViewModel.fromJson(Map<String, dynamic> json) {
    return BookingViewModel(
      bookingId: json['bookingId'],
      mentorId: json['mentorId'],
      menteeId: json['menteeId'],
      startTime: DateTime.parse(json['startTime']),
      duration: json['duration'].toInt(),
      totalCost: json['totalCost'].toDouble(),
      status: json['status'],
      reasonForRejection: json['reasonForRejection'],
      mentor: Mentor.fromJson(json['mentor']),
    );
  }
}
