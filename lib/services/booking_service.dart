import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/request/booking_request_model.dart';
import 'package:mentoo/models/view/booking_view.dart';

import '../utils/path.dart';

class BookingServivce {
  Future<List<BookingViewModel>> fetchBookingViewModel(int menteeId) async {
    if (kDebugMode) {
      print("Calling API...");
    }
    String apiUrl = '${Path.path}/bookings/mentee/$menteeId';
    final response = await http.get(Uri.parse('$apiUrl?id=$menteeId'));
    if (response.statusCode == 200) {
      List<dynamic> jsonArray = json.decode(response.body);
      List<BookingViewModel> bookingViewModels = [];
      for (var jsonObject in jsonArray) {
        bookingViewModels.add(BookingViewModel.fromJson(jsonObject));
      }
      if (kDebugMode) {
        print("Call API Success ...");
      }
      return bookingViewModels;
    } else {
      throw Exception('Failed to load booking view model');
    }
  }

  Future<List<BookingViewModel>> fetchBookingViewModelMentor(
      int mentorId) async {
    if (kDebugMode) {
      print("Calling API...");
    }
    String apiUrl = '${Path.path}/bookings/mentor/$mentorId';
    final response = await http.get(Uri.parse('$apiUrl?id=$mentorId'));
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

  Future<bool> postBooking(BookingRequestModel booking) async {
    var bookingSuccess = false;
    var bookingData = {
      "mentorId": booking.mentorId,
      "menteeId": booking.menteeId,
      "startTime": booking.startTime?.toIso8601String(),
      "duration": booking.duration,
      "totalCost": booking.totalCost,
      "status": booking.status
    };

    HttpClient httpClient = HttpClient();
    String apiUrl = '${Path.path}/bookings';
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(apiUrl));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(bookingData)));
    HttpClientResponse response = await request.close();

    if (response.statusCode == 201) {
      // The API call was successful
      String reply = await response.transform(utf8.decoder).join();
      bookingSuccess = true;
      if (kDebugMode) {
        print(reply);
      }
    } else {
      // The API call was not successful
      bookingSuccess = false;
      if (kDebugMode) {
        print("Failed to create booking, status code: ${response.statusCode}");
      }
    }

    httpClient.close();
    return bookingSuccess;
  }
}
