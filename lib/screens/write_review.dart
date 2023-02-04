import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({super.key});

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  double _rating = 3.0;
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Center(
            child: Stack(
              children: [
                Container(
                  height: 280,
                  width: 350,
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.png"),
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
          SizedBox(
            height: 30,
          ),
          Text(
            "How was your experience with",
            style: AppFonts.medium(18, Colors.black),
          ),
          Text(
            "Mentor Hoang Michael?",
            style: AppFonts.medium(18, AppColors.mDarkPurple),
          ),
          SizedBox(
            height: 30,
          ),
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            //direction: _isVertical ? Axis.vertical : Axis.horizontal,
            //allowHalfRating: true,
            unratedColor: Colors.amber.withAlpha(100),
            itemCount: 5,
            itemSize: 50.0,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
            updateOnDrag: true,
          ),
          SizedBox(
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
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: TextField(
              maxLines: 7,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: "Type your message",
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
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
                  onPressed: () => {})),
        ]),
      ),
    );
  }
}
