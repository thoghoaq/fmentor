import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

class MeetingEnd extends StatelessWidget {
  const MeetingEnd({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Meeting Ended",
              style: AppFonts.medium(22, AppColors.mDarkPurple),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "60:00 Minutes",
              style: AppFonts.bold(30, AppColors.mDarkPurple),
            ),
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
              height: 20,
            ),
            Text(
              "Hoang Michael",
              style: AppFonts.bold(30, AppColors.mDarkPurple),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mLightPurple,
                      fixedSize: const Size(350, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Write a Review',
                        style: AppFonts.medium(
                          16,
                          Colors.white,
                        )),
                    onPressed: () => {})),
            SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      fixedSize: const Size(350, 46),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(
                              color: AppColors.mLightPurple, width: 2)),
                    ),
                    child: Text('Go to dashboard',
                        style: AppFonts.medium(
                          16,
                          AppColors.mLightPurple,
                        )),
                    onPressed: () => {})),
          ]),
    );
  }
}
