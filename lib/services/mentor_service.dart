import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:mentoo/models/metor.dart';
import 'package:mentoo/services/mentee_service.dart';

import 'package:mentoo/models/mentor.dart';

import 'package:mentoo/utils/path.dart';

class MentorService {
  Future<List<Mentor>?> getMentors() async {
    try {
      var url = Uri.parse(Path.path + "/mentors");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Mentor> _mentorModel = mentorFromJson(response.body);
        return _mentorModel;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  Future<List<Mentor>?> getFollowedMentors(int userId) async {
    try {
      var url = Uri.parse(Path.path + "/mentors/followed/" + userId.toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Mentor> _mentorModel = mentorFromJson(response.body);
        return _mentorModel;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  Future<Mentor?> getMentorById(int id) async {
    try {
      var url = Uri.parse(Path.path + "/mentors/" + id.toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Mentor _mentorModel = Mentor.fromJson(jsonDecode(response.body));
        return _mentorModel;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());

    }
  }

  Future<bool?> checkMentorFollowed(int mentorId, int userId) async {
    try {
      String? menteeId = await MenteeService().getMenteeByUserId(userId);
      var url = Uri.parse(Path.path +
          "/mentors/is-followed?mentorId=" +
          mentorId.toString() +
          "&menteeId=" +
          menteeId!);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        bool _isFollowed = jsonDecode(response.body);
        return _isFollowed;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }
}
