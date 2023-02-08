import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/mentor.dart' as mentors;
import 'package:mentoo/models/specialty.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/screens/book_appointment.dart';
import 'package:mentoo/screens/favorite_courses.dart';
import 'package:mentoo/screens/mentor_detail.dart';
import 'package:mentoo/screens/profile.dart';
import 'package:mentoo/screens/search.dart';
import 'package:mentoo/screens/specialist_mentors.dart';
import 'package:mentoo/screens/top_mentor.dart';
import 'package:mentoo/services/mentor_service.dart';
import 'package:mentoo/services/specialty_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/loading.dart';
import 'package:mentoo/widgets/navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<mentors.Mentor>? _mentors;
  List<Specialty>? _specialties;
  User? _user;

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _mentors = (await MentorService().getMentors());
    _specialties = await SpecialtyService().getTop3Specialties();
    (await UserService().getUserById(9));
    _user = (await UserService().getUser());
    setState(() {
      if (_mentors != null && _user != null && _specialties != null)
        isLoaded = true;
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
      bottomNavigationBar: MyBottomNavigationBar(isMentor: 1, initialPage: 0),
      body: !isLoaded
          ? Loading()
          : SingleChildScrollView(
              child: Container(
                height: AppCommon.screenHeight(context) * 2,
                padding:
                    EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.5),
                child: SafeArea(
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 220,
                          child: RichText(
                            text: TextSpan(
                              text: 'Hi ',
                              style: AppFonts.regular(20, Colors.black),
                              children: [
                                TextSpan(
                                    text: _user!.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis)),
                                WidgetSpan(
                                  child: Icon(
                                    Icons.hive_outlined,
                                    size: 20,
                                    color: Colors.yellow,
                                  ),
                                ),
                                TextSpan(text: '\nFind your great mentor!'),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Get.to(FavoriteCourses()),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.favorite,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.mGrayStroke)),
                              child: Icon(
                                Icons.notifications_none_outlined,
                                size: 28,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColors.mGrayStroke)),
                              child: Icon(
                                Icons.person_outline,
                                size: 28,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: AppCommon.screenHeightUnit(context) * 0.3,
                    ),
                    InkWell(
                      onTap: () => {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const Search()),
                        // )
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.mLightPurple,
                            border: Border.all(
                                width: 5, color: AppColors.mLightPurple),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextFormField(
                          decoration: InputDecoration(
                            enabled: false,
                            hintText: "Search for mentor",
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.mDarkPurple,
                            ),
                            contentPadding: const EdgeInsets.only(left: 10),
                            filled: true,
                            fillColor: Colors.white,
                            // focusColor: AppColors.grayColor,
                            // hoverColor: AppColors.grayColor,
                            //labelText: "Search for mentor ",
                            labelStyle: AppFonts.medium(16, AppColors.mText),
                            //errorText: 'Error message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppCommon.screenHeightUnit(context) * 0.3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Specialist Mentors",
                          style: AppFonts.medium(24, Colors.black),
                        ),
                        InkWell(
                          onTap: () => Get.to(SpecialistMentors()),
                          child: RichText(
                            text: TextSpan(
                              text: "See all",
                              style:
                                  AppFonts.regular(16, AppColors.mDarkPurple),
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: AppColors.mDarkPurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppCommon.screenHeightUnit(context) * 0.2,
                    ),
                    Container(
                      height: 170,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _specialties!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(right: 15),
                              width: 105,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: index == 0
                                    ? AppColors.mLightPurple
                                    : (index == 1
                                        ? AppColors.mLightRed
                                        : Colors.amber),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    _specialties![index].picture,
                                    fit: BoxFit.cover,
                                    width: searchAreaContainerWidth * 0.3,
                                    height: searchAreaContainerHeight * 0.35,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Text(
                                      _specialties![index].name,
                                      style: AppFonts.medium(15, Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Text(
                                    _specialties![index]
                                            .numberMentor
                                            .toString() +
                                        " Mentors",
                                    style: AppFonts.regular(13, Colors.white),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                    // Container(
                    //   height: searchAreaContainerHeight,
                    //   width: searchAreaContainerWidth,
                    //   decoration: BoxDecoration(
                    //       color: AppColors.mLightPurple,
                    //       borderRadius: BorderRadius.circular(30)),
                    //   child: Padding(
                    //     padding:
                    //         const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    //     child: Column(children: [
                    //       TextFormField(
                    //         decoration: InputDecoration(
                    //           hintText: "Search for mentor",
                    //           prefixIcon: Icon(
                    //             Icons.search,
                    //             color: AppColors.mDarkPurple,
                    //           ),
                    //           contentPadding: const EdgeInsets.only(left: 10),
                    //           filled: true,
                    //           fillColor: Colors.white,
                    //           // focusColor: AppColors.grayColor,
                    //           // hoverColor: AppColors.grayColor,
                    //           //labelText: "Search for mentor ",
                    //           labelStyle: AppFonts.medium(16, AppColors.mText),
                    //           //errorText: 'Error message',
                    //           border: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(30.0),
                    //               borderSide: BorderSide.none),
                    //         ),
                    //       ),
                    //       SizedBox(
                    //         height: AppCommon.screenHeightUnit(context) * 0.3,
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SizedBox(
                    //             width: searchAreaContainerWidth * 1 / 2 - 10,
                    //             child: RichText(
                    //               maxLines: 3,
                    //               text: TextSpan(
                    //                 text: 'Get connect with ',
                    //                 style: TextStyle(fontSize: 16),
                    //                 children: [
                    //                   TextSpan(
                    //                       text: '300+',
                    //                       style:
                    //                           TextStyle(fontWeight: FontWeight.bold)),
                    //                   TextSpan(
                    //                       text:
                    //                           ' best Mentor and get solutions for your career'),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           Image.asset(
                    //             "assets/images/home_page.png",
                    //             width: searchAreaContainerWidth * 0.3,
                    //             height: searchAreaContainerHeight * 0.5,
                    //           )
                    //         ],
                    //       )
                    //     ]),
                    //   ),
                    // ),
                    SizedBox(
                      height: AppCommon.screenHeightUnit(context) * 0.3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Top Mentors",
                          style: AppFonts.medium(24, Colors.black),
                        ),
                        InkWell(
                          onTap: () => Get.to(TopMentors()),
                          child: RichText(
                            text: TextSpan(
                              text: "See all",
                              style:
                                  AppFonts.regular(16, AppColors.mDarkPurple),
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: AppColors.mDarkPurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: AppCommon.screenHeightUnit(context) * 0.2,
                    ),
                    Container(
                      height: 250,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _mentors!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              // onTap: () => Get.to(Profile(
                              //     isViewMentor: true,
                              //     mentorId: _mentors![index].mentorId)),
                              onTap: () => Get.to(BookAppointment(
                                  menteeId: 1, mentor: _mentors![index])),
                              child: ProfileCard(
                                company: _mentors![index].user.jobs![0].company,
                                job: _mentors![index].user.jobs![0].role,
                                name: _mentors![index].user.name,
                                image: _mentors![index].user.photo,
                              ),
                            );
                          }),
                    ),
                    // Expanded(
                    //   child: GridView.count(
                    //       physics: const NeverScrollableScrollPhysics(),
                    //       padding: EdgeInsets.zero,
                    //       primary: false,
                    //       crossAxisSpacing: 10,
                    //       mainAxisSpacing: 10,
                    //       crossAxisCount: 2,
                    //       childAspectRatio: 0.75,
                    //       children: List.generate(
                    //         10,
                    //         (index) => const ProfileCard(),
                    //       )),
                    // )
                  ]),
                ),
              ),
            ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  ProfileCard({
    required this.company,
    required this.image,
    required this.job,
    required this.name,
    Key? key,
  }) : super(key: key);
  String image;
  String name;
  String company;
  String job;

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: EdgeInsets.only(right: 20),
      //elevation: 5,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        //set border radius more than 50% of height and width to make circle
      ),
      child: Container(
        width: 170,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppFonts.medium(16, Colors.black),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Text(
                  job + ',\n' + company,
                  style: AppFonts.regular(10, Colors.black),
                ),
              ),
              Container(
                width: 90,
                height: 35,
                decoration: BoxDecoration(
                    color: AppColors.mLightPurple,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all()),
                child: Center(
                  child: Text(
                    'Mentor',
                    style: AppFonts.medium(16, Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
