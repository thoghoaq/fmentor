import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/favorite_couse.dart';
import 'package:mentoo/models/follow_mentor.dart';
import 'package:mentoo/models/mentee.dart';
import 'package:mentoo/utils/path.dart';

class MenteeService {
  Future<String?> getMenteeByUserId(int id) async {
    try {
      var url = Uri.parse("${Path.path}/mentees/user/$id");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var mentee = jsonDecode(response.body);
        return mentee["menteeId"].toString();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<Mentee?> getMenteeById(int id) async {
    try {
      var url = Uri.parse("${Path.path}/mentees/$id");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Mentee model = Mentee.fromJson(jsonDecode(response.body));
        return model;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<bool?> favoriteCourse(int userId, int courseId) async {
    try {
      String? menteeId = await getMenteeByUserId(userId);
      var url = Uri.parse(
          "${Path.path}/mentees/favorite_course?courseId=$courseId&menteeId=${menteeId!}");
      var response = await http.post(
        url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        FavoriteCourse favoriteCourse =
            FavoriteCourse.fromJson(jsonDecode(response.body));
        return favoriteCourse.isFavorite;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<bool?> unFavoriteCourse(int userId, int courseId) async {
    try {
      String? menteeId = await getMenteeByUserId(userId);
      var url = Uri.parse(
          "${Path.path}/mentees/unfavorite_course?courseId=$courseId&menteeId=${menteeId!}");
      var response = await http.post(
        url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        FavoriteCourse favoriteCourse =
            FavoriteCourse.fromJson(jsonDecode(response.body));
        return favoriteCourse.isFavorite;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<bool?> followMentor(int userId, int mentorId) async {
    try {
      String? menteeId = await getMenteeByUserId(userId);
      var url = Uri.parse(
          "${Path.path}/mentees/followed_mentor?mentorId=$mentorId&menteeId=${menteeId!}");
      var response = await http.post(
        url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        FollowMentor followMentor =
            FollowMentor.fromJson(jsonDecode(response.body));
        return followMentor.isFollow;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<bool?> unFollowMentor(int userId, int mentorId) async {
    try {
      String? menteeId = await getMenteeByUserId(userId);
      var url = Uri.parse(
          "${Path.path}/mentees/unfollowed_mentor?mentorId=$mentorId&menteeId=${menteeId!}");
      var response = await http.post(
        url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        FollowMentor followMentor =
            FollowMentor.fromJson(jsonDecode(response.body));
        return followMentor.isFollow;
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
