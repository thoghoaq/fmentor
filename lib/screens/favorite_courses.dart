import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';

class FavoriteCourses extends StatefulWidget {
  const FavoriteCourses({super.key});

  @override
  State<FavoriteCourses> createState() => _FavoriteCoursesState();
}

class _FavoriteCoursesState extends State<FavoriteCourses> {
  User? _user;

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    (await UserService().getUserById(9));
    _user = (await UserService().getUser());
    setState(() {
      if (_user != null) isLoaded = true;
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
    return Scaffold(
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
        padding: EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.2),
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(bottom: 10),
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
                              child: Image.asset(
                                "assets/images/home_page.png",
                                width: searchAreaContainerWidth * 0.4,
                                height: searchAreaContainerHeight * 0.4,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "UI/UX Design",
                                style: AppFonts.medium(20, Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Instructure: ',
                                  style: AppFonts.regular(14, Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'FPT University',
                                        style: AppFonts.medium(
                                            14, AppColors.mLightPurple)),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: 'Platform: ',
                                  style: AppFonts.regular(14, Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Coursera',
                                        style: AppFonts.medium(14, Colors.red)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.mGray)),
                              child: Icon(Icons.close)),
                        ],
                      ),
                      SizedBox(
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
