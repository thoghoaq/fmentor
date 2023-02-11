import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/course.dart';
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
}
