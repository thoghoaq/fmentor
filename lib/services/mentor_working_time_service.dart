import 'dart:convert';

import 'package:mentoo/models/view/mentor_working_time_view.dart';
import 'package:mentoo/utils/path.dart';
import 'package:http/http.dart' as http;

class MentorWorkingTimeService {
  Future<List<MentorWorkingTime>> fetchMentorWorkingTime(int? mentorId) async {
    String apiUrl = '${Path.path}/mentorworkingtimes/$mentorId';
    final response = await http.get(Uri.parse('$apiUrl?id=$mentorId'));
    if (response.statusCode == 200) {
      List<dynamic> jsonArray = json.decode(response.body);
      List<MentorWorkingTime> mentorWorkingTime = [];
      for (var jsonObject in jsonArray) {
        mentorWorkingTime.add(MentorWorkingTime.fromJson(jsonObject));
      }
      return mentorWorkingTime;
    } else {
      throw Exception('Failed to load mentor working time view model');
    }
  }
}
