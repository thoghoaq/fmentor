import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/view/appointment_view.dart';
import 'package:mentoo/models/view/booking_view.dart';
import 'package:mentoo/screens/write_review.dart';
import 'package:mentoo/services/appointment_service.dart';
import 'package:mentoo/services/booking_service.dart';
import 'package:mentoo/services/mentee_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/loading.dart';
import 'package:mentoo/widgets/no_data.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppointments extends StatefulWidget {
  final int userId;

  const MyAppointments({
    super.key,
    required this.userId,
  });
  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  bool cancelAppointment = false;
  List<BookingViewModel>? _booking;
  List<AppointmentViewModel>? _upcommingAppointments;
  List<AppointmentViewModel>? _completedAppointments;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var menteeId = await MenteeService().getMenteeByUserId(widget.userId);
    //waiting tab
    var booking =
        await BookingServivce().fetchBookingViewModel(int.parse(menteeId!));
    //fetch all appointment
    var appointments = await AppointmentService()
        .fetchAppointmentViewModel(int.parse(menteeId));
    //upcomming tab
    var upcommingAppointmentsFiltered =
        appointments.where((element) => element.status != "Completed").toList();
    upcommingAppointmentsFiltered
        .sort(((a, b) => b.status.compareTo(a.status)));
    if (!mounted) return;
    setState(() {
      _booking = booking;
      _upcommingAppointments = upcommingAppointmentsFiltered;
      //completed tab
      _completedAppointments = appointments
          .where((element) => element.status == "Completed")
          .toList();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // leading: BackButton(
          //   color: Colors.black,
          //   onPressed: () {},
          // ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppFonts.medium(30, AppColors.mDarkPurple),
          title: const Text(
            'My Appointments',
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 48.0,
              decoration: const BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: TabBar(
                //padding: EdgeInsets.symmetric(horizontal: 20),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: AppColors.mLightPurple,
                    width: 2,
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColors.mLightPurple,
                labelStyle: AppFonts.medium(16, AppColors.mDarkPurple),
                unselectedLabelStyle: AppFonts.medium(16, AppColors.mGray),
                labelColor: AppColors.mDarkPurple,
                unselectedLabelColor: AppColors.mGrayStroke,
                tabs: const [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Waiting'),
                  Tab(text: 'Completed'),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          //color: Colors.amber,
          padding: EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.3),
          child: TabBarView(
            children: [
              _loading
                  ? const Loading()
                  : _upcommingAppointments == null ||
                          _upcommingAppointments!.isEmpty
                      ? NoData()
                      : ListView.builder(
                          itemCount: _upcommingAppointments!.length,
                          itemBuilder: (context, index) {
                            var photo2 = _upcommingAppointments![index]
                                .mentor!
                                .user
                                .photo;
                            var photo3 = _upcommingAppointments![index]
                                .mentor!
                                .user
                                .photo;
                            var name2 = _upcommingAppointments![index]
                                .mentor!
                                .user
                                .name;
                            var role2 = _upcommingAppointments![index]
                                .mentor!
                                .user
                                .jobs!
                                .first
                                .role;
                            var company2 = _upcommingAppointments![index]
                                .mentor!
                                .user
                                .jobs!
                                .first
                                .company;
                            var string = _upcommingAppointments![index]
                                .startTime
                                .toString();
                            var string2 = _upcommingAppointments![index]
                                .duration
                                .toString();
                            var status2 = _upcommingAppointments![index].status;
                            var isEmpty2 = _upcommingAppointments![index]
                                .mentor!
                                .user
                                .photo
                                .replaceAll(" ", "")
                                .isEmpty;
                            return SizedBox(
                              height: 140,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    isEmpty2
                                        ? const CircleAvatar(
                                            backgroundImage: AssetImage(
                                              "assets/images/profile.png",
                                            ),
                                            radius: 45,
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              photo2,
                                            ),
                                            radius: 45,
                                          ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name2,
                                          style:
                                              AppFonts.medium(18, Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: role2,
                                                      style: AppFonts.regular(
                                                          12, Colors.black),
                                                      children: [
                                                    TextSpan(
                                                        text: ", ",
                                                        style: AppFonts.regular(
                                                            12, Colors.black),
                                                        children: [
                                                          TextSpan(
                                                            text: company2,
                                                            style: AppFonts
                                                                .regular(
                                                                    12,
                                                                    Colors
                                                                        .black),
                                                          )
                                                        ])
                                                  ])),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 70,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color:
                                                      _upcommingAppointments![
                                                                      index]
                                                                  .mentor
                                                                  ?.user
                                                                  .isMentor ==
                                                              0
                                                          ? AppColors
                                                              .mLightPurple
                                                          : AppColors.mLightRed,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all()),
                                              child: Center(
                                                child: Text(
                                                  _upcommingAppointments![index]
                                                              .mentor
                                                              ?.user
                                                              .isMentor ==
                                                          0
                                                      ? 'Mentee'
                                                      : 'Mentor',
                                                  style: AppFonts.regular(
                                                      12, Colors.black),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.calendar_today_outlined,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              string,
                                              style: AppFonts.regular(
                                                  12, Colors.black),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.schedule_outlined,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: string2,
                                                  style: AppFonts.regular(
                                                      12, Colors.black),
                                                  children: [
                                                    TextSpan(
                                                      text: " minutes",
                                                      style: AppFonts.regular(
                                                          12, Colors.black),
                                                    )
                                                  ]),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: RichText(
                                            text: TextSpan(
                                              text: "Google Meet - ",
                                              style: AppFonts.regular(
                                                  12, Colors.black),
                                              children: [
                                                TextSpan(
                                                  text: status2,
                                                  style: AppFonts.medium(12,
                                                      AppColors.mDarkPurple),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.black12)),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        Colors.transparent),
                                            shadowColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) =>
                                                        Colors.transparent)),
                                        onPressed: () async {
                                          var url =
                                              _upcommingAppointments![index]
                                                  .googleMeetLink;
                                          if (await canLaunch(url)) {
                                            await launch(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: Image.asset(
                                          "assets/images/google_meet.png",
                                          width: 35,
                                          height: 35,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  width: 250,
                                  child: Divider(color: AppColors.mGray),
                                )
                              ]),
                            );
                          },
                        ),
              _loading
                  ? const Loading()
                  : _booking == null || _booking!.isEmpty
                      ? NoData()
                      : ListView.builder(
                          itemCount: _booking!.length,
                          itemBuilder: (context, index) {
                            var isEmpty2 = _booking![index]
                                .mentor!
                                .user
                                .photo
                                .replaceAll(" ", "")
                                .isEmpty;
                            var photo2 = _booking![index].mentor!.user.photo;
                            var name2 = _booking![index].mentor!.user.name;
                            var role2 =
                                _booking![index].mentor!.user.jobs!.first.role;
                            var company2 = _booking![index]
                                .mentor!
                                .user
                                .jobs!
                                .first
                                .company;
                            return SizedBox(
                              height: 140,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    isEmpty2
                                        ? const CircleAvatar(
                                            backgroundImage: AssetImage(
                                              "assets/images/profile.png",
                                            ),
                                            radius: 45,
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              photo2,
                                            ),
                                            radius: 45,
                                          ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name2,
                                          style:
                                              AppFonts.medium(18, Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: role2,
                                                      style: AppFonts.regular(
                                                          12, Colors.black),
                                                      children: [
                                                    TextSpan(
                                                        text: ", ",
                                                        style: AppFonts.regular(
                                                            12, Colors.black),
                                                        children: [
                                                          TextSpan(
                                                            text: company2,
                                                            style: AppFonts
                                                                .regular(
                                                                    12,
                                                                    Colors
                                                                        .black),
                                                          )
                                                        ])
                                                  ])),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 70,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: _booking![index]
                                                              .mentor
                                                              ?.user
                                                              .isMentor ==
                                                          0
                                                      ? AppColors.mLightPurple
                                                      : AppColors.mLightRed,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all()),
                                              child: Center(
                                                child: Text(
                                                  _booking![index]
                                                              .mentor
                                                              ?.user
                                                              .isMentor ==
                                                          0
                                                      ? 'Mentee'
                                                      : 'Mentor',
                                                  style: AppFonts.regular(
                                                      12, Colors.black),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.calendar_today_outlined,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _booking![index]
                                                  .startTime
                                                  .toString(),
                                              style: AppFonts.regular(
                                                  12, Colors.black),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.schedule_outlined,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "60 minutes",
                                              style: AppFonts.regular(
                                                  12, Colors.black),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: RichText(
                                            text: TextSpan(
                                              text: "Google Meet - ",
                                              style: AppFonts.regular(
                                                  12, Colors.black),
                                              children: [
                                                TextSpan(
                                                  text: _booking![index].status,
                                                  style: AppFonts.medium(
                                                      12, Colors.blue),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                icon: const Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.red,
                                                  size: 100,
                                                ),
                                                iconPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 40),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    30))),
                                                alignment: Alignment.center,
                                                contentPadding:
                                                    const EdgeInsets.all(30),
                                                //insetPadding: EdgeInsets.all(30),
                                                title: Text(
                                                  "Are you want to cancel?",
                                                  style: AppFonts.medium(20,
                                                      AppColors.mDarkPurple),
                                                ),
                                                actionsAlignment:
                                                    MainAxisAlignment.center,
                                                actions: <Widget>[
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 20,
                                                            left: 30),
                                                    width: 120,
                                                    height: 46,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .mLightPurple),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context, 'No'),
                                                      child: Text(
                                                        'No',
                                                        style: AppFonts.medium(
                                                            18,
                                                            AppColors
                                                                .mLightPurple),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 20,
                                                            right: 30),
                                                    width: 120,
                                                    height: 46,
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .mLightPurple,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context, 'Yes'),
                                                      child: Text(
                                                        'Yes',
                                                        style: AppFonts.medium(
                                                            18, Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: const Icon(
                                          Icons.close,
                                          size: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  width: 250,
                                  child: Divider(color: AppColors.mGray),
                                )
                              ]),
                            );
                          },
                        ),
              _loading
                  ? const Loading()
                  : _completedAppointments == null ||
                          _completedAppointments!.isEmpty
                      ? NoData()
                      : ListView.builder(
                          itemCount: _completedAppointments!.length,
                          itemBuilder: (context, index) {
                            var isEmpty2 = _completedAppointments![index]
                                .mentor!
                                .user
                                .photo
                                .replaceAll(" ", "")
                                .isEmpty;
                            var photo2 = _booking![index].mentor!.user.photo;
                            var name2 = _completedAppointments![index]
                                .mentor!
                                .user
                                .name;
                            var role2 = _completedAppointments![index]
                                .mentor!
                                .user
                                .jobs!
                                .first
                                .role;
                            var company2 = _completedAppointments![index]
                                .mentor!
                                .user
                                .jobs!
                                .first
                                .company;
                            return Container(
                              height: 140,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    isEmpty2
                                        ? const CircleAvatar(
                                            backgroundImage: AssetImage(
                                              "assets/images/profile.png",
                                            ),
                                            radius: 45,
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              photo2,
                                            ),
                                            radius: 45,
                                          ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name2,
                                          style:
                                              AppFonts.medium(18, Colors.black),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text: role2,
                                                      style: AppFonts.regular(
                                                          12, Colors.black),
                                                      children: [
                                                    TextSpan(
                                                        text: ", ",
                                                        style: AppFonts.regular(
                                                            12, Colors.black),
                                                        children: [
                                                          TextSpan(
                                                            text: company2,
                                                            style: AppFonts
                                                                .regular(
                                                                    12,
                                                                    Colors
                                                                        .black),
                                                          )
                                                        ])
                                                  ])),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 70,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color:
                                                      _completedAppointments![
                                                                      index]
                                                                  .mentor
                                                                  ?.user
                                                                  .isMentor ==
                                                              0
                                                          ? AppColors
                                                              .mLightPurple
                                                          : AppColors.mLightRed,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all()),
                                              child: Center(
                                                child: Text(
                                                  _completedAppointments![index]
                                                              .mentor
                                                              ?.user
                                                              .isMentor ==
                                                          0
                                                      ? 'Mentee'
                                                      : 'Mentor',
                                                  style: AppFonts.regular(
                                                      12, Colors.black),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.calendar_today_outlined,
                                              size: 16,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _completedAppointments![index]
                                                  .startTime
                                                  .toString(),
                                              style: AppFonts.regular(
                                                  12, Colors.black),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.schedule_outlined,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: _completedAppointments![
                                                          index]
                                                      .duration
                                                      .toString(),
                                                  style: AppFonts.regular(
                                                      12, Colors.black),
                                                  children: [
                                                    TextSpan(
                                                      text: " minutes",
                                                      style: AppFonts.regular(
                                                          12, Colors.black),
                                                    )
                                                  ]),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: RichText(
                                            text: TextSpan(
                                              text: "Google Meet - ",
                                              style: AppFonts.regular(
                                                  12, Colors.black),
                                              children: [
                                                TextSpan(
                                                  text: 'Ended',
                                                  style: AppFonts.medium(12,
                                                      AppColors.mDarkPurple),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    !_completedAppointments![index].isReviewed
                                        ? InkWell(
                                            onTap: () => Get.to(WriteReview(
                                              menteeId:
                                                  _completedAppointments![index]
                                                      .menteeId,
                                              mentee:
                                                  _completedAppointments![index]
                                                      .mentee!,
                                              appointmentId:
                                                  _completedAppointments![index]
                                                      .appointmentId,
                                              mentor:
                                                  _completedAppointments![index]
                                                      .mentor!,
                                            )),
                                            child: Container(
                                                alignment: Alignment.center,
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Colors.black12)),
                                                child: const Icon(
                                                  Icons.rate_review_outlined,
                                                  size: 30,
                                                )),
                                          )
                                        : Container()
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  width: 250,
                                  child: Divider(color: AppColors.mGray),
                                )
                              ]),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
