import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/metor.dart';
import 'package:mentoo/utils/path.dart';

class MentorService {
  Future<List<Mentor>?> getMentor() async {
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
}
