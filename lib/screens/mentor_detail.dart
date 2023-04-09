import 'dart:convert';
import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentoo/models/course.dart';
import 'package:mentoo/models/request/payment_request_model.dart';

import 'package:mentoo/models/user.dart';
import 'package:mentoo/models/view/review_view.dart';
import 'package:mentoo/screens/book_appointment.dart';
import 'package:mentoo/screens/donate.dart';
import 'package:mentoo/screens/payment.dart';
import 'package:mentoo/services/course_service.dart';
import 'package:mentoo/services/donation_service.dart';
import 'package:mentoo/services/mentee_service.dart';
import 'package:http/http.dart' as http;

// ignore: library_prefixes
import 'package:mentoo/models/mentor.dart' as Mentor;

import 'package:mentoo/services/mentor_service.dart';
import 'package:mentoo/services/review_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/services/wallet_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/loading.dart';
import 'package:get/get.dart';

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
  late List<ReviewView>? _reviews;
  List<Course>? _courses;
  late int _senderId;
  late int _receiverId;
  double _donationAmount = 0.0;
  String _description = "";
  Wallet? _wallets;
  late int _courseId;

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  getSenderId() async {
    var user = await UserService().getUser();
    if (user == null) {
      return;
    }
    _wallets =
        await WalletService().getWalletById(user.wallets!.first.walletId);
    _senderId = user.userId;
  }

  void _getData() async {
    _user = (await UserService().getUser());
    _menteeId = await MenteeService().getMenteeByUserId(_user!.userId);
    _mentor = (await MentorService().getMentorById(widget.mentorId))!;
    _isFollowed = await MentorService()
        .checkMentorFollowed(_mentor.mentorId, _user!.userId);
    _reviews = await ReviewService().getReviewsByRevieweeId(_mentor.userId);
    _courses = await CourseService().getCoursesByMentorId(_mentor.mentorId);
    getSenderId();
    setState(() {
      if (_user != null && _courses != null) isLoaded = true;
    });
    setState(() {
      isLoaded = true;
    });
  }

  _pay(PaymentRequestModel model) async {
    var response = await _createNewPayment(model);
    if (response!.statusCode == 500) {
      throw Exception("Can not pay");
    }
    return response.body;
  }

  Future<http.Response?> _createNewPayment(PaymentRequestModel model) async {
    String apiUrl = 'https://dev-empire-api.azurewebsites.net/api/v1/payment';
    final response = await http.post(Uri.parse(apiUrl),
        body: jsonEncode({
          'orderType': model.orderType,
          'amount': model.amount,
          'orderDescription': model.orderDescription,
          'name': model.name
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJqdGkiOiIyZjk1OWMzNC00ZDA4LTQ4OTgtYTU4Mi1iOTQwNGFlMjE0ODgiLCJ1bmlxdWVfbmFtZSI6IlRow7RuZyBIb8OgbmciLCJuYW1laWQiOiI5Iiwicm9sZSI6IlVTIiwibmJmIjoxNjgxMDI1NjIxLCJleHAiOjE3MTI2NDgwMjEsImlhdCI6MTY4MTAyNTYyMX0.89zScQ3cmmmBEef-ZDG3VnA3gPWH4yG_Ezsp1UvKAs4'
        });
    if (response.statusCode == 200) {
      log('Payment data sent successfully');
    } else {
      log('Error sending payment data: ${response.statusCode}');
    }
    return response;
  }

  _onCallBackFromPayment() async {
    var message = await DonationService()
        .donate(_senderId, _mentor.userId, _donationAmount, _description);
    // ignore: use_build_context_synchronously
    if (message.statusCode == 200) {
      await MenteeService()
          .favoriteCourse(int.parse(_menteeId.toString()), _courseId);
    }
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
                              text: "Courses",
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
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _mentor.user.jobs![index]
                                                          .role,
                                                      style: AppFonts.medium(
                                                          18, Colors.black),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    Text(
                                                      _mentor.user.jobs![index]
                                                          .company,
                                                      style: AppFonts.medium(
                                                          14,
                                                          AppColors
                                                              .mGrayStroke),
                                                    ),
                                                    const SizedBox(
                                                      width: 30,
                                                    ),
                                                    Text(
                                                      "${DateFormat("MMMM yyyy").format(_mentor.user.jobs![index].startDate)} - ${_mentor.user.jobs![index].endDate == null ? "Now" : DateFormat("MMMM yyyy").format(_mentor.user.jobs![index].endDate!)}",
                                                      style: AppFonts.regular(
                                                          12,
                                                          AppColors
                                                              .mGrayStroke),
                                                    )
                                                  ],
                                                ),
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 1500,
                                  child: ListView.builder(
                                    itemCount:
                                        _reviews != null ? _reviews!.length : 0,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            leading: CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                  _reviews![index]
                                                      .reviewer
                                                      .photo),
                                            ),
                                            title: Text(
                                                _reviews![index].reviewer.name),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                RatingBar.builder(
                                                  initialRating:
                                                      _reviews![index]
                                                          .rating
                                                          .toDouble(),
                                                  minRating: 1,
                                                  //direction: _isVertical ? Axis.vertical : Axis.horizontal,
                                                  //allowHalfRating: true,
                                                  unratedColor:
                                                      Colors.transparent,
                                                  itemCount: 5,
                                                  itemSize: 15.0,
                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 1.0),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate:
                                                      (double value) {},
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                      _reviews![index].comment),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Divider()
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            _courses != null
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        SizedBox(
                                          height: 1500,
                                          child: ListView.builder(
                                              padding: const EdgeInsets.all(8),
                                              itemCount: _courses!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var searchAreaContainerWidth =
                                                    AppCommon.screenWidthUnit(
                                                            context) *
                                                        11;
                                                var searchAreaContainerHeight =
                                                    AppCommon.screenHeightUnit(
                                                            context) *
                                                        3;
                                                switch (
                                                    _courses![index].courseId) {
                                                  case 35:
                                                    _donationAmount = 20000;
                                                    break;
                                                  case 36:
                                                    _donationAmount = 35000;
                                                    break;
                                                  case 37:
                                                    _donationAmount = 10000;
                                                    break;
                                                  case 38:
                                                    _donationAmount = 5000;
                                                    break;
                                                  case 39:
                                                    _donationAmount = 17000;
                                                    break;
                                                  default:
                                                }
                                                return Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              height: 70,
                                                              width: 70,
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .mBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              child: Center(
                                                                child: Image
                                                                    .network(
                                                                  _courses![
                                                                          index]
                                                                      .photo,
                                                                  width:
                                                                      searchAreaContainerWidth *
                                                                          0.4,
                                                                  height:
                                                                      searchAreaContainerHeight *
                                                                          0.4,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  _courses![
                                                                          index]
                                                                      .title,
                                                                  style: AppFonts
                                                                      .medium(
                                                                          20,
                                                                          Colors
                                                                              .black),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    text:
                                                                        'Instructure: ',
                                                                    style: AppFonts
                                                                        .regular(
                                                                            14,
                                                                            Colors.black),
                                                                    children: <
                                                                        TextSpan>[
                                                                      TextSpan(
                                                                          text: _courses![index]
                                                                              .instructor,
                                                                          style: AppFonts.medium(
                                                                              14,
                                                                              AppColors.mLightPurple)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    text:
                                                                        'Platform: ',
                                                                    style: AppFonts
                                                                        .regular(
                                                                            14,
                                                                            Colors.black),
                                                                    children: <
                                                                        TextSpan>[
                                                                      TextSpan(
                                                                          text: _courses![index]
                                                                              .platform,
                                                                          style: AppFonts.medium(
                                                                              14,
                                                                              Colors.red)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                RichText(
                                                                  text:
                                                                      TextSpan(
                                                                    text:
                                                                        'Price: ',
                                                                    style: AppFonts
                                                                        .regular(
                                                                            14,
                                                                            Colors.black),
                                                                    children: <
                                                                        TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              '$_donationAmountđ',
                                                                          style: AppFonts.medium(
                                                                              14,
                                                                              Colors.green)),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              setState(() {
                                                                isLoaded =
                                                                    false;
                                                              });
                                                              PaymentRequestModel
                                                                  paymentRequestModel =
                                                                  PaymentRequestModel(
                                                                      amount:
                                                                          _donationAmount,
                                                                      name:
                                                                          'BC',
                                                                      orderDescription:
                                                                          'BC',
                                                                      orderType:
                                                                          'VNPay');
                                                              var responsePayment =
                                                                  await _pay(
                                                                      paymentRequestModel);
                                                              _description =
                                                                  'BC-${_courses![index].courseId}-VNPay';
                                                              _courseId =
                                                                  _courses![
                                                                          index]
                                                                      .courseId;
                                                              Get.to(PaymenPage(
                                                                url:
                                                                    responsePayment,
                                                                callback:
                                                                    _onCallBackFromPayment,
                                                              ));
                                                            },
                                                            child: Container(
                                                                height: 40,
                                                                width: 40,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .mGray)),
                                                                child: const Icon(
                                                                    Icons
                                                                        .shopping_cart_checkout)),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 30,
                                                        width: 250,
                                                        child: Divider(
                                                          color:
                                                              AppColors.mGray,
                                                        ),
                                                      )
                                                    ]);
                                              }),
                                        )
                                      ])
                                : Container()
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
            left: 110,
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
                    color: AppColors.mLightRed,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        shadowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AppColors.mLightPurple)),
                    onPressed: () => Get.to(BookAppointment(
                        mentor: mentor, menteeId: int.parse(menteeId))),
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
                          Expanded(
                            child: Text(
                              "Book Apppointment",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ]),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(DonationPage(
                        receiverId: mentor.userId,
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        shadowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.transparent),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xff36894D))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(Icons.monetization_on_outlined),
                        Text(
                          " Donate",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
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
