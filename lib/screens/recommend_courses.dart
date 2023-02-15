import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/course.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/screens/main_home_page.dart';
import 'package:mentoo/services/course_service.dart';
import 'package:mentoo/services/mentee_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/loading.dart';

class RecommendCourses extends StatefulWidget {
  RecommendCourses({super.key, this.courses});
  List<Course>? courses;

  @override
  State<RecommendCourses> createState() => _RecommendCoursesState();
}

class _RecommendCoursesState extends State<RecommendCourses> {
  User? _user;

  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _user ??= await UserService().getUser();

    if (_user != null) {
      isLoaded = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                  itemCount: widget.courses!.length,
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
                                    child: widget.courses![index].photo == " "
                                        ? Image.asset(
                                            "assets/images/home_page.png",
                                            width:
                                                searchAreaContainerWidth * 0.3,
                                            height:
                                                searchAreaContainerHeight * 0.3,
                                          )
                                        : Image.network(
                                            widget.courses![index].photo,
                                            width:
                                                searchAreaContainerWidth * 0.3,
                                            height:
                                                searchAreaContainerHeight * 0.3,
                                          ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.courses![index].title,
                                      style: AppFonts.medium(16, Colors.black),
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
                                              text: widget
                                                  .courses![index].instructor,
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
                                              text: widget
                                                  .courses![index].platform,
                                              style: AppFonts.medium(
                                                  14, Colors.red)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                    onTap: () async {
                                      await MenteeService().favoriteCourse(
                                          17, widget.courses![index].courseId);
                                    },
                                    child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.red),
                                        child: const Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: 30,
                                        ))),
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
                    onPressed: () => {
                          Get.to(MainPage(
                            isMentor: 0,
                            initialPage: 0,
                            userId: 1,
                          ))
                        })),
          ]),
    );
  }
}
