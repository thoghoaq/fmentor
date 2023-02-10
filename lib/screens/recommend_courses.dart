import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';

class RecommendCourses extends StatefulWidget {
  const RecommendCourses({super.key});

  @override
  State<RecommendCourses> createState() => _RecommendCoursesState();
}

class _RecommendCoursesState extends State<RecommendCourses> {
  @override
  Widget build(BuildContext context) {
    var searchAreaContainerWidth = AppCommon.screenWidthUnit(context) * 11;
    var searchAreaContainerHeight = AppCommon.screenHeightUnit(context) * 3;
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/recommend_courses.png",
                width: 350,
                height: 350,
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Text(
              "Great!",
              style: AppFonts.medium(40, AppColors.mDarkPurple),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Text(
              "Mentor recommend courses to you",
              maxLines: 2,
              style: AppFonts.medium(20, AppColors.mDarkPurple),
            ),
            Container(
              height: 270,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 120,
                      alignment: Alignment.center,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: AppColors.mBackground,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/home_page.png",
                                      width: searchAreaContainerWidth * 0.4,
                                      height: searchAreaContainerHeight * 0.4,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "UI/UX Design",
                                      style: AppFonts.medium(20, Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Instructure: ',
                                        style:
                                            AppFonts.regular(14, Colors.black),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'FPT University',
                                              style: AppFonts.medium(
                                                  14, AppColors.mLightPurple)),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Platform: ',
                                        style:
                                            AppFonts.regular(14, Colors.black),
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Coursera',
                                              style: AppFonts.medium(
                                                  14, Colors.red)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red),
                                    child: const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 40,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                              width: 250,
                              child: Divider(
                                color: AppColors.mGray,
                              ),
                            )
                          ]),
                    );
                  }),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mLightPurple,
                      fixedSize: const Size(300, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('OK',
                        style: AppFonts.medium(
                          16,
                          Colors.white,
                        )),
                    onPressed: () => {})),
          ]),
    );
  }
}
