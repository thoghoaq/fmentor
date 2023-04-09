import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/course.dart';
import 'package:mentoo/screens/main_home_page.dart';
import 'package:mentoo/services/mentor_service.dart';
import 'package:mentoo/utils/path.dart';

class CourseService {
  Future<List<Course>?> getFavoriteCourses(int id) async {
    try {
      var url = Uri.parse("${Path.path}/courses/favorite/$id");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Course> courses = courseFromJson(response.body);
        return courses;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<List<Course>?> getCourses() async {
    try {
      var url = Uri.parse("${Path.path}/courses");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Course> courses = courseFromJson(response.body);
        return courses;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<List<Course>?> getCoursesByMentorId(int id) async {
    try {
      var mentorId = await MentorService().getMentorIdByUserId(id);
      var men = 1;
      var url = Uri.parse("${Path.path}/courses/mentor/$id");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Course> courses = courseFromJson(response.body);
        return courses;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<void> recommendCourse(String token, List<int>? courses) async {
    try {
      var url = Uri.parse("${Path.path}/courses/recommended-courses/$token");
      var response = await http.post(url,
          headers: {"accept": "text/plain", "Content-Type": "application/json"},
          body: jsonEncode(courses));
      if (response.statusCode == 200) {
        print("recommend course success");
        Get.to(MainPage(isMentor: 0, initialPage: 0, userId: 1));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
  }

  Future<List<Course>?> getCoursesRecommended(String coursesId) async {
    try {
      var courseIds = coursesId.substring(1, coursesId.length - 1);
      List<int> ids = [];
      if (courseIds.length > 1) {
        var numbers = courseIds.split(",");
        for (var element in numbers) {
          ids.add(int.parse(element));
        }
      } else {
        ids.add(int.parse(courseIds));
      }
      var url = Uri.parse("${Path.path}/courses/recommended-course");
      var response = await http.post(url,
          headers: {"accept": "text/plain", "Content-Type": "application/json"},
          body: jsonEncode(ids));
      if (response.statusCode == 200) {
        print("recommend course success");
        return (courseFromJson(response.body));
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
