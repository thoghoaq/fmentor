import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/course.dart';
import 'package:mentoo/utils/path.dart';

class CourseService {
  Future<List<Course>?> getFavoriteCourses(int id) async {
    try {
      var url = Uri.parse(Path.path + "/courses/favorite/" + id.toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Course> _courses = courseFromJson(response.body);
        return _courses;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }
}
