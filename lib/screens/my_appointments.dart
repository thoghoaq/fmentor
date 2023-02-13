import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/view/appointment_view.dart';
import 'package:mentoo/models/view/booking_view.dart';
import 'package:mentoo/screens/write_review.dart';
import 'package:mentoo/services/appointment_service.dart';
import 'package:mentoo/services/booking_service.dart';
import 'package:mentoo/services/mentee_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/loading.dart';
import 'package:mentoo/widgets/no_data.dart';
// ignore: import_of_legacy_library_into_null_safe
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
                      ? const NoData()
                      : ListUpcommingAppointment(
                          upcommingAppointments: _upcommingAppointments),
              _loading
                  ? const Loading()
                  : _booking == null || _booking!.isEmpty
                      ? const NoData()
                      : ListBookingItem(booking: _booking),
              _loading
                  ? const Loading()
                  : _completedAppointments == null ||
                          _completedAppointments!.isEmpty
                      ? const NoData()
                      : ListCompleteAppointment(
                          completedAppointments: _completedAppointments),
            ],
          ),
        ),
      ),
    );
  }
}

class ListUpcommingAppointment extends StatelessWidget {
  const ListUpcommingAppointment({
    Key? key,
    required List<AppointmentViewModel>? upcommingAppointments,
  })  : _upcommingAppointments = upcommingAppointments,
        super(key: key);

  final List<AppointmentViewModel>? _upcommingAppointments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _upcommingAppointments!.length,
      itemBuilder: (context, index) {
        var photo2 = _upcommingAppointments![index].mentor!.user.photo;
        var name2 = _upcommingAppointments![index].mentor!.user.name;
        var role2 =
            _upcommingAppointments![index].mentor!.user.jobs!.first.role;
        var company2 =
            _upcommingAppointments![index].mentor!.user.jobs!.first.company;
        var string = _upcommingAppointments![index]
            .startTime
            .toString()
            .substring(0, 16);
        var string2 = _upcommingAppointments![index].duration.toString();
        var status2 = _upcommingAppointments![index].status;
        var isEmpty2 = _upcommingAppointments![index]
            .mentor!
            .user
            .photo
            .replaceAll(" ", "")
            .isEmpty;
        var isMentor2 = _upcommingAppointments![index].mentor?.user.isMentor;
        var password2 = _upcommingAppointments![index].password;
        var googleMeetLink2 = _upcommingAppointments![index].googleMeetLink;
        return UpcommingAppointmentDetail(
            isEmpty2: isEmpty2,
            photo2: photo2,
            isMentor2: isMentor2,
            name2: name2,
            role2: role2,
            company2: company2,
            string: string,
            string2: string2,
            status2: status2,
            password2: password2,
            upcommingAppointments: _upcommingAppointments,
            googleMeetLink2: googleMeetLink2);
      },
    );
  }
}

class UpcommingAppointmentDetail extends StatelessWidget {
  const UpcommingAppointmentDetail({
    Key? key,
    required this.isEmpty2,
    required this.photo2,
    required this.isMentor2,
    required this.name2,
    required this.role2,
    required this.company2,
    required this.string,
    required this.string2,
    required this.status2,
    required this.password2,
    required this.googleMeetLink2,
    required List<AppointmentViewModel>? upcommingAppointments,
  })  : _upcommingAppointments = upcommingAppointments,
        super(key: key);

  final bool isEmpty2;
  final String photo2;
  final int? isMentor2;
  final String name2;
  final String role2;
  final String company2;
  final String string;
  final String string2;
  final String status2;
  final String password2;
  final String googleMeetLink2;
  final List<AppointmentViewModel>? _upcommingAppointments;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Avatar(isEmpty2: isEmpty2, photo2: photo2, isMentor2: isMentor2),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name2,
                  style: AppFonts.medium(18, Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: AppCommon.screenWidthUnit(context) * 5,
                      child: RichText(
                          text: TextSpan(
                              text: role2,
                              style: AppFonts.regular(12, Colors.black),
                              children: [
                            TextSpan(
                                text: ", ",
                                style: AppFonts.regular(12, Colors.black),
                                children: [
                                  TextSpan(
                                    text: company2,
                                    style: AppFonts.regular(12, Colors.black),
                                  )
                                ])
                          ])),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      style: AppFonts.regular(12, Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          style: AppFonts.regular(12, Colors.black),
                          children: [
                            TextSpan(
                              text: " minutes",
                              style: AppFonts.regular(12, Colors.black),
                            )
                          ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: "Zoom - ",
                    style: AppFonts.regular(12, Colors.black),
                    children: [
                      TextSpan(
                        text: status2,
                        style: AppFonts.medium(12, AppColors.mDarkPurple),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: "Password:$password2",
                    style: AppFonts.regular(12, Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              alignment: Alignment.center,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12)),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent),
                    shadowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent)),
                onPressed: () async {
                  var url = googleMeetLink2;
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
            ),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      const SizedBox(
        width: 300,
        child: Divider(color: AppColors.mGray),
      )
    ]);
  }
}

class Avatar extends StatelessWidget {
  const Avatar({
    Key? key,
    required this.isEmpty2,
    required this.photo2,
    required this.isMentor2,
  }) : super(key: key);

  final bool isEmpty2;
  final String photo2;
  final int? isMentor2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 110,
          width: 100,
          child: isEmpty2
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
        ),
        Container(
          height: 110,
          width: 100,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 70,
            height: 20,
            decoration: BoxDecoration(
                color: isMentor2 == 0
                    ? AppColors.mLightPurple
                    : AppColors.mLightRed,
                borderRadius: BorderRadius.circular(7),
                border: Border.all()),
            child: Center(
              child: Text(
                isMentor2 == 0 ? 'Mentee' : 'Mentor',
                style: AppFonts.regular(12, Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ListCompleteAppointment extends StatelessWidget {
  const ListCompleteAppointment({
    Key? key,
    required List<AppointmentViewModel>? completedAppointments,
  })  : _completedAppointments = completedAppointments,
        super(key: key);

  final List<AppointmentViewModel>? _completedAppointments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _completedAppointments!.length,
      itemBuilder: (context, index) {
        var isEmpty2 = _completedAppointments![index]
            .mentor!
            .user
            .photo
            .replaceAll(" ", "")
            .isEmpty;
        var photo2 = _completedAppointments![index].mentor!.user.photo;
        var name2 = _completedAppointments![index].mentor!.user.name;
        var role2 =
            _completedAppointments![index].mentor!.user.jobs!.first.role;
        var company2 =
            _completedAppointments![index].mentor!.user.jobs!.first.company;
        var isMentor2 = _completedAppointments![index].mentor?.user.isMentor;
        var string = _completedAppointments![index].startTime.toString();
        var string2 = _completedAppointments![index].duration.toString();
        var isReviewed2 = _completedAppointments![index].isReviewed;
        return Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Avatar(isEmpty2: isEmpty2, photo2: photo2, isMentor2: isMentor2),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name2,
                      style: AppFonts.medium(18, Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: RichText(
                              text: TextSpan(
                                  text: role2,
                                  style: AppFonts.regular(12, Colors.black),
                                  children: [
                                TextSpan(
                                    text: ", ",
                                    style: AppFonts.regular(12, Colors.black),
                                    children: [
                                      TextSpan(
                                        text: company2,
                                        style:
                                            AppFonts.regular(12, Colors.black),
                                      )
                                    ])
                              ])),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          style: AppFonts.regular(12, Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                              style: AppFonts.regular(12, Colors.black),
                              children: [
                                TextSpan(
                                  text: " minutes",
                                  style: AppFonts.regular(12, Colors.black),
                                )
                              ]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Zoom - ",
                        style: AppFonts.regular(12, Colors.black),
                        children: [
                          TextSpan(
                            text: 'Ended',
                            style: AppFonts.medium(12, AppColors.mDarkPurple),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              !isReviewed2
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => Get.to(WriteReview(
                          menteeId: _completedAppointments![index].menteeId,
                          mentee: _completedAppointments![index].mentee!,
                          appointmentId:
                              _completedAppointments![index].appointmentId,
                          mentor: _completedAppointments![index].mentor!,
                        )),
                        child: Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black12)),
                            child: const Icon(
                              Icons.rate_review_outlined,
                              size: 30,
                            )),
                      ),
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
        ]);
      },
    );
  }
}

class ListBookingItem extends StatelessWidget {
  const ListBookingItem({
    Key? key,
    required List<BookingViewModel>? booking,
  })  : _booking = booking,
        super(key: key);

  final List<BookingViewModel>? _booking;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _booking!.length,
      itemBuilder: (context, index) {
        var isEmpty2 =
            _booking![index].mentor!.user.photo.replaceAll(" ", "").isEmpty;
        var photo2 = _booking![index].mentor!.user.photo;
        var name2 = _booking![index].mentor!.user.name;
        var role2 = _booking![index].mentor!.user.jobs!.first.role;
        var company2 = _booking![index].mentor!.user.jobs!.first.company;
        var isMentor2 = _booking![index].mentor?.user.isMentor;
        var string = _booking![index].startTime.toString();
        var status2 = _booking![index].status;
        var booking2 = _booking![index];
        var menteeId2 = booking2.mentorId;
        return BookingDetail(
          isEmpty2: isEmpty2,
          photo2: photo2,
          isMentor2: isMentor2,
          name2: name2,
          role2: role2,
          company2: company2,
          string: string,
          status2: status2,
          booking: _booking,
          booking2: booking2,
          menteeId2: menteeId2,
        );
      },
    );
  }
}

class BookingDetail extends StatelessWidget {
  const BookingDetail({
    Key? key,
    required this.isEmpty2,
    required this.photo2,
    required this.isMentor2,
    required this.name2,
    required this.role2,
    required this.company2,
    required this.string,
    required this.status2,
    required List<BookingViewModel>? booking,
    required this.booking2,
    required this.menteeId2,
  })  : _booking = booking,
        super(key: key);

  final bool isEmpty2;
  final String photo2;
  final int? isMentor2;
  final String name2;
  final String role2;
  final String company2;
  final String string;
  final String status2;
  final BookingViewModel booking2;
  final int menteeId2;
  final List<BookingViewModel>? _booking;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Avatar(isEmpty2: isEmpty2, photo2: photo2, isMentor2: isMentor2),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name2,
                  style: AppFonts.medium(18, Colors.black),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: role2,
                              style: AppFonts.regular(12, Colors.black),
                              children: [
                                TextSpan(
                                    text: ", ",
                                    style: AppFonts.regular(12, Colors.black),
                                    children: [
                                      TextSpan(
                                        text: company2,
                                        style:
                                            AppFonts.regular(12, Colors.black),
                                      )
                                    ])
                              ])),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      style: AppFonts.regular(12, Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      style: AppFonts.regular(12, Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                  text: TextSpan(
                    text: "Zoom - ",
                    style: AppFonts.regular(12, Colors.black),
                    children: [
                      TextSpan(
                        text: status2,
                        style: AppFonts.medium(12, Colors.blue),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                          size: 100,
                        ),
                        iconPadding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 40),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        alignment: Alignment.center,
                        contentPadding: const EdgeInsets.all(30),
                        //insetPadding: EdgeInsets.all(30),
                        title: Text(
                          "Are you want to cancel?",
                          style: AppFonts.medium(20, AppColors.mDarkPurple),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 30),
                            width: 120,
                            height: 46,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: AppColors.mLightPurple),
                                borderRadius: BorderRadius.circular(30)),
                            child: TextButton(
                              onPressed: () => Navigator.pop(context, 'No'),
                              child: Text(
                                'No',
                                style:
                                    AppFonts.medium(18, AppColors.mLightPurple),
                              ),
                            ),
                          ),
                          Container(
                            margin:
                                const EdgeInsets.only(bottom: 20, right: 30),
                            width: 120,
                            height: 46,
                            decoration: BoxDecoration(
                                color: AppColors.mLightPurple,
                                borderRadius: BorderRadius.circular(30)),
                            child: TextButton(
                              onPressed: () => Navigator.pop(context, 'Yes'),
                              child: Text(
                                'Yes',
                                style: AppFonts.medium(18, Colors.white),
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
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12)),
                child: const Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      const SizedBox(
        width: 300,
        child: Divider(color: AppColors.mGray),
      ),
    ]);
  }
}
