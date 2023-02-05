import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mentoo/models/view/booking_view.dart';

import '../utils/path.dart';

class BookingServivce {
  Future<List<BookingViewModel>> fetchBookingViewModel(int? menteeId) async {
    String apiUrl = Path.path + '/bookings/mentee/${menteeId}';
    final response =
        await http.get(Uri.parse(apiUrl + '?id=' + menteeId.toString()));
    if (response.statusCode == 200) {
      List<dynamic> jsonArray = json.decode(response.body);
      List<BookingViewModel> bookingViewModels = [];
      for (var jsonObject in jsonArray) {
        bookingViewModels.add(BookingViewModel.fromJson(jsonObject));
      }
      return bookingViewModels;
    } else {
      throw Exception('Failed to load booking view model');
    }
  }
}
