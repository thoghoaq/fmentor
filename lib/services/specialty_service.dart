import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/specialty.dart';
import 'package:mentoo/utils/path.dart';

class SpecialtyService {
  Future<List<Specialty>?> getSpecialties() async {
    try {
      var url = Uri.parse("${Path.path}/specialties");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        // List<Specialty> specialties = specialtyFromJson(response.body);
        // return specialties;
        final specialtiesJson = jsonDecode(response.body);
        final specialties = <Specialty>[];

        for (var specialtyJson in specialtiesJson) {
          specialties.add(Specialty.fromJson(specialtyJson));
        }

        return specialties;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<List<Specialty>?> getTop3Specialties() async {
    try {
      var url = Uri.parse("${Path.path}/specialties/top3");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<Specialty> specialties = specialtyFromJson(response.body);
        return specialties;
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
