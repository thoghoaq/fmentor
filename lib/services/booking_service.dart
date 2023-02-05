import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mentoo/models/view/booking_view.dart';

import '../utils/path.dart';

class BookingServivce {
  Future<BookingViewModel> fetchBookingViewModel() async {
    final response = await http.get(Uri.parse(Path.path + "/bookings/mentee"));

    if (response.statusCode == 200) {
      return BookingViewModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load booking view model');
    }
  }
}
