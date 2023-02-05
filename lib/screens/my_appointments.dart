import 'package:flutter/material.dart';
import 'package:mentoo/models/view/appointment_view.dart';
import 'package:mentoo/models/view/booking_view.dart';
import 'package:mentoo/services/appointment_service.dart';
import 'package:mentoo/services/booking_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/loading.dart';
import 'package:mentoo/widgets/no_data.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAppointments extends StatefulWidget {
  final int? menteeId;

  const MyAppointments({super.key, this.menteeId});
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
    //waiting tab
    _booking = await BookingServivce().fetchBookingViewModel(widget.menteeId);
    //fetch all appointment
    var appointments =
        await AppointmentService().fetchAppointmentViewModel(widget.menteeId);
    //upcomming tab
    var upcommingAppointmentsFiltered =
        appointments.where((element) => element.status != "Completed").toList();
    upcommingAppointmentsFiltered
        .sort(((a, b) => b.status.compareTo(a.status)));
    _upcommingAppointments = upcommingAppointmentsFiltered;
    //completed tab
    _completedAppointments =
        appointments.where((element) => element.status == "Completed").toList();

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () {},
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: AppFonts.medium(30, AppColors.mDarkPurple),
          title: const Text(
            'My Appointments',
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 48.0,
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: TabBar(
                //padding: EdgeInsets.symmetric(horizontal: 20),
                indicator: UnderlineTabIndicator(
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
                tabs: [
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
                  ? Loading()
                  : _upcommingAppointments == null ||
                          _upcommingAppointments!.isEmpty
                      ? NoData()
                      : ListView.builder(
                          itemCount: _upcommingAppointments!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 140,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _upcommingAppointments![index]
                                            .mentor
                                            .user
                                            .photo
                                            .replaceAll(" ", "")
                                            .isEmpty
                                        ? CircleAvatar(
                                            backgroundImage: AssetImage(
                                              "assets/images/profile.png",
                                            ),
                                            radius: 45,
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              _booking![index]
                                                  .mentor
                                                  .user
                                                  .photo,
                                            ),
                                            radius: 45,
                                          ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _upcommingAppointments![index]
                                              .mentor
                                              .user
                                              .name,
                                          style:
                                              AppFonts.medium(18, Colors.black),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            RichText(
                                                text: TextSpan(
                                                    text:
                                                        _upcommingAppointments![
                                                                index]
                                                            .mentor
                                                            .user
                                                            .jobs
                                                            .first
                                                            .role,
                                                    style: AppFonts.regular(
                                                        12, Colors.black),
                                                    children: [
                                                  TextSpan(
                                                      text: ", ",
                                                      style: AppFonts.regular(
                                                          12, Colors.black),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              _upcommingAppointments![
                                                                      index]
                                                                  .mentor
                                                                  .user
                                                                  .jobs
                                                                  .first
                                                                  .company,
                                                          style:
                                                              AppFonts.regular(
                                                                  12,
                                                                  Colors.black),
                                                        )
                                                      ])
                                                ])),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 70,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: AppColors.mLightRed,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all()),
                                              child: Center(
                                                child: Text(
                                                  'Mentor',
                                                  style: AppFonts.regular(
                                                      12, Colors.black),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              _upcommingAppointments![index]
                                                  .startTime
                                                  .toString(),
                                              style: AppFonts.regular(
                                                  12, Colors.black),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.schedule_outlined,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                  text: _upcommingAppointments![
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
                                        SizedBox(
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
                                                  text: _upcommingAppointments![
                                                          index]
                                                      .status,
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
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Divider(color: AppColors.mGray),
                                )
                              ]),
                            );
                          },
                        ),
              _loading
                  ? Loading()
                  : _booking == null || _booking!.isEmpty
                      ? NoData()
                      : ListView.builder(
                          itemCount: _booking!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 140,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _booking![index]
                                            .mentor
                                            .user
                                            .photo
                                            .replaceAll(" ", "")
                                            .isEmpty
                                        ? CircleAvatar(
                                            backgroundImage: AssetImage(
                                              "assets/images/profile.png",
                                            ),
                                            radius: 45,
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              _booking![index]
                                                  .mentor
                                                  .user
                                                  .photo,
                                            ),
                                            radius: 45,
                                          ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _booking![index].mentor.user.name,
                                          style:
                                              AppFonts.medium(18, Colors.black),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            RichText(
                                                text: TextSpan(
                                                    text: _booking![index]
                                                        .mentor
                                                        .user
                                                        .jobs
                                                        .first
                                                        .role,
                                                    style: AppFonts.regular(
                                                        12, Colors.black),
                                                    children: [
                                                  TextSpan(
                                                      text: ", ",
                                                      style: AppFonts.regular(
                                                          12, Colors.black),
                                                      children: [
                                                        TextSpan(
                                                          text: _booking![index]
                                                              .mentor
                                                              .user
                                                              .jobs
                                                              .first
                                                              .company,
                                                          style:
                                                              AppFonts.regular(
                                                                  12,
                                                                  Colors.black),
                                                        )
                                                      ])
                                                ])),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 70,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: AppColors.mLightRed,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all()),
                                              child: Center(
                                                child: Text(
                                                  'Mentor',
                                                  style: AppFonts.regular(
                                                      12, Colors.black),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              size: 16,
                                            ),
                                            SizedBox(
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
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.schedule_outlined,
                                              size: 18,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "60 minutes",
                                              style: AppFonts.regular(
                                                  12, Colors.black),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
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
                                                icon: Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.red,
                                                  size: 100,
                                                ),
                                                iconPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 40),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30))),
                                                alignment: Alignment.center,
                                                contentPadding:
                                                    EdgeInsets.all(30),
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
                                                    margin: EdgeInsets.only(
                                                        bottom: 20, left: 30),
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
                                                    margin: EdgeInsets.only(
                                                        bottom: 20, right: 30),
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
                                        child: Icon(
                                          Icons.close,
                                          size: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Divider(color: AppColors.mGray),
                                )
                              ]),
                            );
                          },
                        ),
              _loading
                  ? Loading()
                  : _completedAppointments == null ||
                          _completedAppointments!.isEmpty
                      ? NoData()
                      : ListView.builder(
                          itemCount: _completedAppointments!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 140,
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _completedAppointments![index]
                                            .mentor
                                            .user
                                            .photo
                                            .replaceAll(" ", "")
                                            .isEmpty
                                        ? CircleAvatar(
                                            backgroundImage: AssetImage(
                                              "assets/images/profile.png",
                                            ),
                                            radius: 45,
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              _booking![index]
                                                  .mentor
                                                  .user
                                                  .photo,
                                            ),
                                            radius: 45,
                                          ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _completedAppointments![index]
                                              .mentor
                                              .user
                                              .name,
                                          style:
                                              AppFonts.medium(18, Colors.black),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            RichText(
                                                text: TextSpan(
                                                    text:
                                                        _completedAppointments![
                                                                index]
                                                            .mentor
                                                            .user
                                                            .jobs
                                                            .first
                                                            .role,
                                                    style: AppFonts.regular(
                                                        12, Colors.black),
                                                    children: [
                                                  TextSpan(
                                                      text: ", ",
                                                      style: AppFonts.regular(
                                                          12, Colors.black),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              _completedAppointments![
                                                                      index]
                                                                  .mentor
                                                                  .user
                                                                  .jobs
                                                                  .first
                                                                  .company,
                                                          style:
                                                              AppFonts.regular(
                                                                  12,
                                                                  Colors.black),
                                                        )
                                                      ])
                                                ])),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 70,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  color: AppColors.mLightRed,
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                  border: Border.all()),
                                              child: Center(
                                                child: Text(
                                                  'Mentor',
                                                  style: AppFonts.regular(
                                                      12, Colors.black),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              size: 16,
                                            ),
                                            SizedBox(
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
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.schedule_outlined,
                                              size: 18,
                                            ),
                                            SizedBox(
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
                                        SizedBox(
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
                                    Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: Icon(
                                          Icons.rate_review_outlined,
                                          size: 30,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
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
