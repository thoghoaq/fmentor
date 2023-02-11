import 'dart:developer';

import 'package:mentoo/models/mentor.dart';
import 'package:mentoo/models/request/education_request_model.dart';
import 'package:mentoo/utils/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EducationService {
  Future<Education?> getEducation(int id) async {
    try {
      var url = Uri.parse(Path.path + "/educations/" + id.toString());
      var response = await http.get(
        url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        Education _education = Education.fromJson(jsonDecode(response.body));
        return _education;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Education?> addEducation(EducationRequestModel education) async {
    var url = Uri.parse(Path.path + "/educations");
    var response = await http.post(url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
        body: jsonEncode(education));

    if (response.statusCode == 201) {
      Education _education = Education.fromJson(jsonDecode(response.body));
      return _education;
    } else
      throw Exception(response.body);
  }

  Future<Education?> updateEducation(
      EducationRequestModel education, int id) async {
    var url = Uri.parse(Path.path + "/educations/" + id.toString());
    var response = await http.put(url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
        body: jsonEncode(education));

    if (response.statusCode == 200) {
      Education _education = Education.fromJson(jsonDecode(response.body));
      return _education;
    } else
      throw Exception(response.body);
  }
}
