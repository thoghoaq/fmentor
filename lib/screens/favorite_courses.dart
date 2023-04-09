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
import 'package:url_launcher/url_launcher.dart';

class FavoriteCourses extends StatefulWidget {
  const FavoriteCourses({super.key});

  @override
  State<FavoriteCourses> createState() => _FavoriteCoursesState();
}

class _FavoriteCoursesState extends State<FavoriteCourses> {
  User? _user;
  List<Course>? _courses;

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _user = (await UserService().getUser());
    var menteeId = await MenteeService().getMenteeByUserId(_user!.userId);
    _courses = await CourseService()
        .getFavoriteCourses(int.parse(menteeId.toString()));
    setState(() {
      if (_user != null && _courses != null) isLoaded = true;
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
                'Favorite courses',
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
                      //color: Colors.amber[100],
                      alignment: Alignment.center,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () async {
                                      var url = _courses![index].link;
                                      if (await canLaunchUrl(Uri.parse(url))) {
                                        await launchUrl(Uri.parse(url));
                                      } else {
                                        throw "Could not launch $url";
                                      }
                                    },
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: AppColors.mBackground,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                        child: Image.network(
                                          _courses![index].photo,
                                          width: searchAreaContainerWidth * 0.4,
                                          height:
                                              searchAreaContainerHeight * 0.4,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _courses![index].title,
                                        style:
                                            AppFonts.medium(20, Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Instructure: ',
                                          style: AppFonts.regular(
                                              14, Colors.black),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    _courses![index].instructor,
                                                style: AppFonts.medium(14,
                                                    AppColors.mLightPurple)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Platform: ',
                                          style: AppFonts.regular(
                                              14, Colors.black),
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
                                ),
                                InkWell(
                                  onTap: () async {
                                    await MenteeService().unFavoriteCourse(
                                        _user!.userId,
                                        _courses![index].courseId);
                                    _courses = await CourseService()
                                        .getFavoriteCourses(_user!.userId);
                                    if (_courses != null) {
                                      setState(() {
                                        isLoaded = true;
                                      });
                                    }
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: AppColors.mGray)),
                                      child: const Icon(Icons.close)),
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
          );
  }
}
