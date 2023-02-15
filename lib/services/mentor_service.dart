import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:mentoo/services/mentee_service.dart';

import 'package:mentoo/models/mentor.dart';

import 'package:mentoo/utils/path.dart';

class MentorService {
  Future<List<Mentor>?> getMentors() async {
    try {
      var url = Uri.parse("${Path.path}/mentors");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Mentor> mentorModel = mentorFromJson(response.body);
        return mentorModel;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<List<Mentor>?> getFollowedMentors(int userId) async {
    try {
      var url = Uri.parse("${Path.path}/mentors/followed/$userId");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Mentor> mentorModel = mentorFromJson(response.body);
        return mentorModel;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<String?> getMentorIdByUserId(int id) async {
    try {
      var url = Uri.parse("${Path.path}/mentors/user/$id");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var mentor = jsonDecode(response.body);
        return mentor["mentorId"].toString();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<Mentor?> getMentorById(int id) async {
    try {
      var url = Uri.parse("${Path.path}/mentors/$id");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Mentor mentorModel = Mentor.fromJson(jsonDecode(response.body));
        return mentorModel;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<bool?> checkMentorFollowed(int mentorId, int userId) async {
    try {
      String? menteeId = await MenteeService().getMenteeByUserId(userId);
      var url = Uri.parse(
          "${Path.path}/mentors/is-followed?mentorId=$mentorId&menteeId=${menteeId!}");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        bool isFollowed = jsonDecode(response.body);
        return isFollowed;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }
}
