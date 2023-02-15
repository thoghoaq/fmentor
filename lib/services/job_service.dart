import 'package:mentoo/models/mentor.dart';
import 'package:mentoo/models/request/job_request_model.dart';
import 'package:mentoo/utils/path.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class JobService {
  Future<Job?> getJob(int id) async {
    try {
      var url = Uri.parse(Path.path + "/jobs/" + id.toString());
      var response = await http.get(url, headers: {
        "accept": "text/plain",
        "Content-Type": "application/json"
      });

      if (response.statusCode == 200) {
        Job _job = Job.fromJson(jsonDecode(response.body));
        return _job;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Job?> addJob(JobRequestModel job) async {
    var url = Uri.parse(Path.path + "/jobs");
    var response = await http.post(url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
        body: jsonEncode(job));

    if (response.statusCode == 201) {
      Job _job = Job.fromJson(jsonDecode(response.body));
      return _job;
    } else
      throw Exception(response.body);
  }

  Future<Job?> editJob(JobRequestModel job, int id) async {
    var url = Uri.parse(Path.path + "/jobs/" + id.toString());
    var response = await http.put(url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
        body: jsonEncode(job));

    if (response.statusCode == 200) {
      Job _job = Job.fromJson(jsonDecode(response.body));
      return _job;
    } else
      throw Exception(response.body);
  }
}
