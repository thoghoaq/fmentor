import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';

class SpecialistMentors extends StatelessWidget {
  const SpecialistMentors({super.key});

  @override
  Widget build(BuildContext context) {
    var searchAreaContainerWidth = AppCommon.screenWidthUnit(context) * 11;
    var searchAreaContainerHeight = AppCommon.screenHeightUnit(context) * 3;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: AppFonts.medium(30, AppColors.mDarkPurple),
        title: const Text(
          'Specialist Mentors',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.2),
        child: GridView.count(
            padding: EdgeInsets.zero,
            primary: false,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            children: List.generate(
              10,
              (index) => Container(
                width: 105,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.mLightPurple,
                ),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/home_page.png",
                      width: searchAreaContainerWidth * 0.25,
                      height: searchAreaContainerHeight * 0.35,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "UX/UI Design",
                      style: AppFonts.medium(15, Colors.white),
                      maxLines: 2,
                    ),
                    // Text(
                    //   "Design",
                    //   style: AppFonts.medium(15, Colors.white),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "65 Mentors",
                      style: AppFonts.regular(13, Colors.white),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
