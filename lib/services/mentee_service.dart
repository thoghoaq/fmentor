import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/favorite_couse.dart';
import 'package:mentoo/models/follow_mentor.dart';
import 'package:mentoo/models/mentee.dart';
import 'package:mentoo/utils/path.dart';

class MenteeService {
  Future<String?> getMenteeByUserId(int id) async {
    try {
      var url = Uri.parse(Path.path + "/mentees/user/" + id.toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var _mentee = jsonDecode(response.body);
        return _mentee["menteeId"].toString();
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  Future<bool?> favoriteCourse(int userId, int courseId) async {
    try {
      String? menteeId = await getMenteeByUserId(userId);
      var url = Uri.parse(Path.path +
          "/mentees/favorite_course?courseId=" +
          courseId.toString() +
          "&menteeId=" +
          menteeId!);
      var response = await http.post(
        url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        FavoriteCourse _favoriteCourse =
            FavoriteCourse.fromJson(jsonDecode(response.body));
        return _favoriteCourse.isFavorite;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  Future<bool?> unFavoriteCourse(int userId, int courseId) async {
    try {
      String? menteeId = await getMenteeByUserId(userId);
      var url = Uri.parse(Path.path +
          "/mentees/unfavorite_course?courseId=" +
          courseId.toString() +
          "&menteeId=" +
          menteeId!);
      var response = await http.post(
        url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        FavoriteCourse _favoriteCourse =
            FavoriteCourse.fromJson(jsonDecode(response.body));
        return _favoriteCourse.isFavorite;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  Future<bool?> followMentor(int userId, int mentorId) async {
    try {
      String? menteeId = await getMenteeByUserId(userId);
      var url = Uri.parse(Path.path +
          "/mentees/followed_mentor?mentorId=" +
          mentorId.toString() +
          "&menteeId=" +
          menteeId!);
      var response = await http.post(
        url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        FollowMentor _followMentor =
            FollowMentor.fromJson(jsonDecode(response.body));
        return _followMentor.isFollow;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  Future<bool?> unFollowMentor(int userId, int mentorId) async {
    try {
      String? menteeId = await getMenteeByUserId(userId);
      var url = Uri.parse(Path.path +
          "/mentees/unfollowed_mentor?mentorId=" +
          mentorId.toString() +
          "&menteeId=" +
          menteeId!);
      var response = await http.post(
        url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        FollowMentor _followMentor =
            FollowMentor.fromJson(jsonDecode(response.body));
        return _followMentor.isFollow;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }
}
