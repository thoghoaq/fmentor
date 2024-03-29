import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:mentoo/models/user.dart';
import 'package:mentoo/models/view/booking_view.dart';
import 'package:mentoo/services/appointment_service.dart';
import 'package:mentoo/services/booking_service.dart';
import 'package:mentoo/services/mentee_service.dart';

// ignore: library_prefixes
import 'package:mentoo/models/mentee.dart' as Mentee;

import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/widgets/alert_dialog.dart';
import 'package:mentoo/widgets/loading.dart';

// ignore: must_be_immutable
class MenteeDetail extends StatefulWidget {
  BookingViewModel? booking;
  int menteeId;
  MenteeDetail({Key? key, required this.menteeId, this.booking})
      : super(key: key);

  @override
  State<MenteeDetail> createState() => _MenteeDetailState();
}

class _MenteeDetailState extends State<MenteeDetail> {
  late Mentee.Mentee _mentee;
  User? _user;
  late String _menteeId;
  bool? _isFollowed;
  BookingViewModel? _booking;

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _menteeId = widget.menteeId.toString();
    var mentee = await MenteeService().getMenteeById(int.parse(_menteeId));
    setState(() {
      _isFollowed = false;
      _mentee = mentee!;
      _user = _mentee.user;
      isLoaded = true;
      _booking = widget.booking;
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
                        mentee: _mentee,
                        isFollowed: _isFollowed!,
                        menteeId: _menteeId,
                        booking: _booking),
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
                                Text(_mentee.user.description),
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
                                      _mentee.user.jobs!.length.toDouble(),
                                  child: ListView.builder(
                                    itemCount: _mentee.user.jobs!.length,
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
                                                    "Marketer",
                                                    style: AppFonts.medium(
                                                        18, Colors.black),
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Text(
                                                    "Shoppe",
                                                    style: AppFonts.medium(14,
                                                        AppColors.mGrayStroke),
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Text(
                                                    "${DateFormat("MMMM yyyy").format(_mentee.user.jobs![index].startDate)} - ${_mentee.user.jobs![index].endDate == null ? "Now" : DateFormat("MMMM yyyy").format(_mentee.user.jobs![index].endDate!)}",
                                                    style: AppFonts.regular(12,
                                                        AppColors.mGrayStroke),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          index != _mentee.user.jobs!.length - 1
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
  Mentee.Mentee mentee;
  bool isFollowed;
  int userId;
  String menteeId;
  BookingViewModel? booking;
  bool bookingSuccess = false;

  CustomSliverAppBarDelegate(
      {required this.expandedHeight,
      required this.mentee,
      required this.isFollowed,
      required this.userId,
      required this.menteeId,
      required this.booking});

  void showDialogWidget(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => bookingSuccess
            ? AlertPopup(
                icon: Image.asset("assets/images/booking_success.png"),
                title: "Sucess",
                message:
                    "Your appointment make successfully completed. Follow your time to meet mentee",
                buttons: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: Text(
                      'OK',
                      style: AppFonts.medium(18, Colors.white),
                    ),
                  ),
                ],
              )
            : AlertPopup(
                icon: Image.asset("assets/images/booking_fail.png"),
                title: "Opps, Failed",
                message: "Something when wrong",
                buttons: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: Text(
                      'Try again',
                      style: AppFonts.medium(18, Colors.white),
                    ),
                  ),
                ],
              ));
  }

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
        buildBackground(shrinkOffset, mentee),
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
                ]),
          ),
        ),
        Positioned(
          top: 320,
          left: 20,
          right: 20,
          child: buildFloating(shrinkOffset, context),
        ),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset * 0.01 / expandedHeight;

  double disappear(double shrinkOffset) =>
      1 - (shrinkOffset / expandedHeight * 10) * 0.01;

  Widget buildBackground(double shrinkOffset, Mentee.Mentee mentee) => Opacity(
        opacity: disappear(shrinkOffset),
        child: mentee.user.photo.replaceAll(" ", "").isNotEmpty
            ? Image.network(
                mentee.user.photo,
                fit: BoxFit.cover,
              )
            : Image.asset(
                "assets/images/profile.png",
                fit: BoxFit.cover,
              ),
      );

  Widget buildFloating(double shrinkOffset, BuildContext context) => Visibility(
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
                    text: '${mentee.user.name} ',
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
                mentee.user.jobs != null && mentee.user.jobs!.isNotEmpty
                    ? "${mentee.user.jobs![0].role}, ${mentee.user.jobs![0].company}"
                    : "No job data",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
              ),
              const SizedBox(
                height: 5,
              ),
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
                    'Mentee',
                    style: AppFonts.medium(16, Colors.black),
                  ),
                ),
              )),
            ),
          ),
          InkWell(
            onTap: () async {
              if (booking != null) {
                bookingSuccess = await AppointmentService()
                    .createAppointment(booking!.bookingId, null);
                // ignore: use_build_context_synchronously
                showDialogWidget(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Center(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: 150,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 24, 128, 56),
                  ),
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                        Icon(
                          Icons.approval_outlined,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Accept",
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
