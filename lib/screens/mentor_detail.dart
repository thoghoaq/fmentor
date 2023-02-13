import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:mentoo/models/user.dart';
import 'package:mentoo/screens/book_appointment.dart';
import 'package:mentoo/services/mentee_service.dart';

// ignore: library_prefixes
import 'package:mentoo/models/mentor.dart' as Mentor;

import 'package:mentoo/services/mentor_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/widgets/loading.dart';

// ignore: must_be_immutable
class MentorDetail extends StatefulWidget {
  int mentorId;
  MentorDetail({Key? key, required this.mentorId}) : super(key: key);

  @override
  State<MentorDetail> createState() => _MentorDetailState();
}

class _MentorDetailState extends State<MentorDetail> {
  late Mentor.Mentor _mentor;
  User? _user;
  String? _menteeId;
  bool? _isFollowed;

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _user = (await UserService().getUser());
    _menteeId = await MenteeService().getMenteeByUserId(_user!.userId);
    _mentor = (await MentorService().getMentorById(widget.mentorId))!;
    _isFollowed = await MentorService()
        .checkMentorFollowed(_mentor.mentorId, _user!.userId);
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? const Loading()
        : DefaultTabController(
            length: 3,
            child: Scaffold(
              body: CustomScrollView(
                controller: ScrollController(initialScrollOffset: 0),
                physics: const BouncingScrollPhysics(),
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: CustomSliverAppBarDelegate(
                        userId: _user!.userId,
                        expandedHeight: 500,
                        mentor: _mentor,
                        isFollowed: _isFollowed!,
                        menteeId: _menteeId!),
                  ),
                  const SliverAppBar(
                    //expandedHeight: 0,
                    backgroundColor: Colors.white,
                    pinned: true,
                    // title: Text(
                    //   "Profile",
                    //   style: TextStyle(color: AppColors.mLightPurple),
                    // ),
                    centerTitle: true,
                    elevation: 0,
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(0.0),
                      child: TabBar(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          indicatorColor: AppColors.mLightPurple,
                          labelColor: AppColors.mLightPurple,
                          labelStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          unselectedLabelColor: AppColors.mGrayStroke,
                          // ignore: prefer_const_literals_to_create_immutables
                          tabs: [
                            Tab(
                              text: "Profile",
                            ),
                            Tab(
                              text: "Reviews",
                            ),
                            Tab(
                              text: "Cetificates",
                            ),
                          ]),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          margin: const EdgeInsets.only(top: 0),
                          height: 2000,
                          child: TabBarView(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_mentor.user.description),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "More...",
                                  style:
                                      TextStyle(color: AppColors.mGrayStroke),
                                ),
                                const Center(
                                  child: SizedBox(
                                    width: 250,
                                    child: Divider(
                                      thickness: 2,
                                      height: 30,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 100 *
                                      _mentor.user.jobs!.length.toDouble(),
                                  child: ListView.builder(
                                    itemCount: _mentor.user.jobs!.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(width: 30),
                                              const Icon(
                                                Icons.adjust_rounded,
                                                size: 30,
                                                color: AppColors.mLightPurple,
                                              ),
                                              const SizedBox(width: 30),
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColors
                                                            .mGrayStroke),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Image.asset(
                                                  'assets/images/apple.png',
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _mentor
                                                        .user.jobs![index].role,
                                                    style: AppFonts.medium(
                                                        18, Colors.black),
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Text(
                                                    _mentor.user.jobs![index]
                                                        .company,
                                                    style: AppFonts.medium(14,
                                                        AppColors.mGrayStroke),
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Text(
                                                    "${DateFormat("MMMM yyyy").format(_mentor.user.jobs![index].startDate)} - ${_mentor.user.jobs![index].endDate == null ? "Now" : DateFormat("MMMM yyyy").format(_mentor.user.jobs![index].endDate!)}",
                                                    style: AppFonts.regular(12,
                                                        AppColors.mGrayStroke),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          index != _mentor.user.jobs!.length - 1
                                              ? const Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 43),
                                                  child: DottedLine(
                                                    lineLength: 50,
                                                    dashColor:
                                                        AppColors.mDarkPurple,
                                                    direction: Axis.vertical,
                                                    lineThickness: 2,
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Text("Comming soon"),
                            const Text("Comming soon"),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  Mentor.Mentor mentor;
  bool isFollowed;
  int userId;
  String menteeId;

  CustomSliverAppBarDelegate(
      {required this.expandedHeight,
      required this.mentor,
      required this.isFollowed,
      required this.userId,
      required this.menteeId});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      //overflow: Overflow.visible,
      children: [
        Container(
          height: 500,
          color: Colors.amber,
        ),
        buildBackground(shrinkOffset, mentor),
        Positioned(
          top: 400,
          right: 0,
          child: Visibility(
            visible: shrinkOffset > 0 ? false : true,
            child: Container(
              height: 100,
              width: 500,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          right: 20,
          child: SizedBox(
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const BackButtonIcon()),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: IconButton(
                          onPressed: () async {
                            if (isFollowed) {
                              await MenteeService()
                                  .unFollowMentor(userId, mentor.mentorId);
                            } else {
                              await MenteeService()
                                  .followMentor(userId, mentor.mentorId);
                            }
                            //function();
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MentorDetail(
                                  mentorId: mentor.mentorId,
                                ),
                              ),
                            );
                          },
                          icon: !isFollowed
                              ? const Icon(Icons.person_add_alt)
                              : const Icon(Icons.person_remove_alt_1)),
                    ),
                  ),
                ]),
          ),
        ),
        Positioned(
          top: 320,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset * 0.01 / expandedHeight;

  double disappear(double shrinkOffset) =>
      1 - (shrinkOffset / expandedHeight * 10) * 0.01;

  Widget buildBackground(double shrinkOffset, Mentor.Mentor mentor) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Image.network(
          mentor.user.photo,
          fit: BoxFit.cover,
        ),
      );

  Widget buildFloating(double shrinkOffset) => Visibility(
        visible: shrinkOffset > 0 ? false : true,
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            height: 150,
            width: 500,
            padding: const EdgeInsets.only(
              top: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(children: [
              InkWell(
                // ignore: avoid_print
                onTap: () => print("tap"),
                child: RichText(
                  text: TextSpan(
                    text: '${mentor.user.name} ',
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: const [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(
                          Icons.verified_outlined,
                          size: 25,
                          color: AppColors.mLightPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${mentor.user.jobs![0].role}, ${mentor.user.jobs![0].company}",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "${mentor.numberMentee} Mentees, ${mentor.numberMentee} Followers",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              )
            ]),
          ),
          Positioned(
            top: -25,
            left: 145,
            child: Container(
              alignment: Alignment.topCenter,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              child: Center(
                  child: Container(
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
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 115),
            child: InkWell(
              onTap: () => Get.to(BookAppointment(
                  mentor: mentor, menteeId: int.parse(menteeId))),
              child: Center(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  width: 250,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.mLightPurple,
                  ),
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                        Icon(
                          Icons.calendar_month_sharp,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Book Appointment",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ])),
                ),
              ),
            ),
          ),
        ]),
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight + 30;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
