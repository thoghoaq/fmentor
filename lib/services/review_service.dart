import 'package:flutter/foundation.dart';
import 'package:mentoo/models/review.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/view/review_view.dart' as review_view;
import 'package:mentoo/utils/path.dart';

class ReviewService {
  Future<Review?> createReview(Review review) async {
    try {
      var url = Uri.parse("${Path.path}/reviews");
      var response = await http.post(url,
          headers: {"accept": "text/plain", "Content-Type": "application/json"},
          body: jsonEncode(review));

      if (response.statusCode == 201) {
        Review review = Review.fromJson(jsonDecode(response.body));

        return review;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<List<review_view.ReviewView>?> getReviewsByRevieweeId(int id) async {
    try {
      var url = Uri.parse("${Path.path}/reviews/reviewee/$id");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final reviewsJson = jsonDecode(response.body);
        final reviews = <review_view.ReviewView>[];

        for (var reviewJson in reviewsJson) {
          reviews.add(review_view.ReviewView.fromJson(reviewJson));
        }

        return reviews;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
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
