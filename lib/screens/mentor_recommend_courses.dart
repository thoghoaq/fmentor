import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/course.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/services/course_service.dart';
import 'package:mentoo/services/mentee_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/loading.dart';

class MentorRecommendCourses extends StatefulWidget {
  MentorRecommendCourses({super.key, required this.token});
  String token;

  @override
  State<MentorRecommendCourses> createState() => _MentorRecommendCoursesState();
}

class _MentorRecommendCoursesState extends State<MentorRecommendCourses> {
  User? _user;
  List<Course>? _courses;
  List<bool> _isAdds = [];
  List<int> _recommendedCourese = [];

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _user = (await UserService().getUser());
    _courses = await CourseService().getCoursesByMentorId(_user!.userId);
    setState(() {
      if (_user != null && _courses != null) {
        for (var course in _courses!) {
          _isAdds.add(false);
        }
        isLoaded = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var searchAreaContainerWidth = AppCommon.screenWidthUnit(context) * 11;
    var searchAreaContainerHeight = AppCommon.screenHeightUnit(context) * 3;
    return !isLoaded
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.black,
                onPressed: () => Get.back(),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              titleTextStyle: AppFonts.medium(30, AppColors.mDarkPurple),
              title: const Text(
                'My courses',
              ),
            ),
            body: Padding(
              padding:
                  EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.2),
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _courses!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 120,
                      //color: Colors.amber[100],
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
                                    child: _courses![index].photo == " "
                                        ? Image.asset(
                                            "assets/images/home_page.png",
                                            width:
                                                searchAreaContainerWidth * 0.4,
                                            height:
                                                searchAreaContainerHeight * 0.4,
                                          )
                                        : Image.network(
                                            _courses![index].photo,
                                            width:
                                                searchAreaContainerWidth * 0.4,
                                            height:
                                                searchAreaContainerHeight * 0.4,
                                          ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _courses![index].title,
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
                                              text: _courses![index].instructor,
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
                                              text: _courses![index].platform,
                                              style: AppFonts.medium(
                                                  14, Colors.red)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    _recommendedCourese
                                        .add(_courses![index].courseId);
                                    setState(() {
                                      _isAdds[index] = true;
                                    });
                                  },
                                  child: !_isAdds[index]
                                      ? Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: AppColors.mGray)),
                                          child: const Icon(Icons.add))
                                      : Container(),
                                ),
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
            bottomNavigationBar: Container(
                height: 60,
                margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mLightPurple,
                      fixedSize: const Size(390, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Recommended Courses',
                        style: AppFonts.medium(
                          16,
                          Colors.white,
                        )),
                    onPressed: () async {
                      await CourseService()
                          .recommendCourse(widget.token, _recommendedCourese);
                    })),
          );
  }
}
