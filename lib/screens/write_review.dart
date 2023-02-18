import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/mentee.dart';
import 'package:mentoo/models/mentor.dart';
import 'package:mentoo/models/review.dart';
import 'package:mentoo/screens/my_appointments.dart';
import 'package:mentoo/services/review_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class WriteReview extends StatefulWidget {
  WriteReview(
      {super.key,
      required this.appointmentId,
      required this.mentee,
      required this.mentor,
      required this.menteeId});
  int appointmentId;
  Mentor mentor;
  Mentee mentee;
  int menteeId;

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  double _rating = 3.0;
  late String _comment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppFonts.medium(30, AppColors.mDarkPurple),
        title: const Text(
          'Write a Review',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.4),
        child: ListView(children: [
          Center(
            child: Stack(
              children: [
                Container(
                  height: 280,
                  width: 350,
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.mentor.user.photo),
                    radius: 120,
                  ),
                ),
                Positioned(
                  top: 250,
                  left: 140,
                  child: Container(
                    width: 70,
                    height: 25,
                    decoration: BoxDecoration(
                        color: AppColors.mLightPurple,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all()),
                    child: Center(
                      child: Text(
                        'Mentor',
                        style: AppFonts.regular(12, Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "How was your experience with",
              style: AppFonts.medium(18, Colors.black),
            ),
          ),
          Center(
            child: Text(
              "Mentor ${widget.mentor.user.name}?",
              style: AppFonts.medium(18, AppColors.mLightPurple),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              //direction: _isVertical ? Axis.vertical : Axis.horizontal,
              //allowHalfRating: true,
              unratedColor: Colors.amber.withAlpha(100),
              itemCount: 5,
              itemSize: 50.0,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                  //print(rating);
                });
              },
              updateOnDrag: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Write a comment",
                style: AppFonts.medium(16, Colors.black),
              ),
              Text(
                "Max 250 words",
                style: AppFonts.regular(16, Colors.black),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: TextField(
              onChanged: (value) {
                _comment = value;
                //print(value);
              },
              maxLines: 7,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: "Type your message",
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mLightPurple,
                    fixedSize: const Size(390, 46),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text('Submit Review',
                      style: AppFonts.medium(
                        16,
                        Colors.white,
                      )),
                  onPressed: () async {
                    Review review = Review(
                      reviewId: 0,
                      appointmentId: widget.appointmentId,
                      reviewerId: widget.mentor.userId,
                      revieweeId: widget.mentee.userId,
                      rating: _rating.toInt(),
                      comment: _comment,
                    );
                    if (await ReviewService().createReview(review) != null) {
                      Get.to(MyAppointments(
                        userId: widget.menteeId,
                      ));
                    }
                  })),
        ]),
      ),
    );
  }
}
