import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/specialty.dart';
import 'package:mentoo/utils/path.dart';

class SpecialtyService {
  Future<List<Specialty>?> getSpecialties() async {
    try {
      var url = Uri.parse(Path.path + "/specialties");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Specialty> _specialties = specialtyFromJson(response.body);
        return _specialties;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  Future<List<Specialty>?> getTop3Specialties() async {
    try {
      var url = Uri.parse(Path.path + "/specialties/top3");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Specialty> _specialties = specialtyFromJson(response.body);
        return _specialties;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }
}
