import 'package:get/get.dart';
import 'package:mentoo/models/review.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mentoo/screens/my_appointments.dart';
import 'package:mentoo/utils/path.dart';

class ReviewService {
  Future<Review?> createReview(Review review) async {
    try {
      var url = Uri.parse(Path.path + "/reviews");
      var response = await http.post(url,
          headers: {"accept": "text/plain", "Content-Type": "application/json"},
          body: jsonEncode(review));

      if (response.statusCode == 201) {
        Review _review = Review.fromJson(jsonDecode(response.body));

        return _review;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  // Future<Review?> getReviewById(int appointmentId, int mentorId, int menteeId) async {
  //   try {
  //     var url = Uri.parse(Path.path + "/mentors/" + id.toString());
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       Mentor _mentorModel = Mentor.fromJson(jsonDecode(response.body));
  //       return _mentorModel;
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //     log(e.toString());
  //   }
  // }
}
