class BookingRequestModel {
  int? mentorId;
  int? menteeId;
  DateTime? startTime;
  int? duration;
  double? totalCost;
  String? status;

  BookingRequestModel({
    this.mentorId,
    this.menteeId,
    this.startTime,
    this.duration,
    this.totalCost,
    this.status,
  });
}
