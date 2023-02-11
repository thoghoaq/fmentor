import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/view/appointment_view.dart';

import '../utils/path.dart';

class AppointmentService {
  Future<List<AppointmentViewModel>> fetchAppointmentViewModel(
      int? menteeId) async {
    String apiUrl = '${Path.path}/appointments/mentee/$menteeId';
    final response = await http.get(Uri.parse('$apiUrl?id=$menteeId'));
    if (response.statusCode == 200) {
      List<dynamic> jsonArray = json.decode(response.body);
      List<AppointmentViewModel> viewModels = [];
      for (var jsonObject in jsonArray) {
        viewModels.add(AppointmentViewModel.fromJson(jsonObject));
      }
      return viewModels;
    } else {
      throw Exception('Failed to load booking view model');
    }
  }

  Future<List<AppointmentViewModel>> fetchAppointmentViewModelMentor(
      int? mentorId) async {
    String apiUrl = '${Path.path}/appointments/mentor/$mentorId';
    final response = await http.get(Uri.parse('$apiUrl?id=$mentorId'));
    if (response.statusCode == 200) {
      List<dynamic> jsonArray = json.decode(response.body);
      List<AppointmentViewModel> viewModels = [];
      for (var jsonObject in jsonArray) {
        viewModels.add(AppointmentViewModel.fromJson(jsonObject));
      }
      return viewModels;
    } else {
      throw Exception('Failed to load booking view model');
    }
  }

  Future<bool> createAppointment(int bookingId, String? note) async {
    String apiUrl = '${Path.path}/appointments';
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({'bookingId': bookingId, 'note': note}),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
