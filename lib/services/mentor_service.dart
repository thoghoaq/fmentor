import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/metor.dart';
import 'package:mentoo/utils/path.dart';

class MentorService {
  Future<List<Mentor>?> getMentors() async {
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

  Future<Mentor?> getMentorById(int? id) async {
    String apiUrl = Path.path + '/mentors/${id}';
    print("Calling API load mentor...");
    final response = await http.get(Uri.parse(apiUrl + '?id=' + id.toString()));
    if (response.statusCode == 200) {
      Mentor mentor = Mentor.fromJson(json.decode(response.body));
      return mentor;
    } else {
      throw Exception('Failed to load mentor model');
    }
  }
}
