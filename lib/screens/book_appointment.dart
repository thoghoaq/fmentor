import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:get/route_manager.dart';
import 'package:mentoo/models/mentor.dart';

import 'package:mentoo/models/request/booking_request_model.dart';
import 'package:mentoo/models/view/mentor_working_time_view.dart';
import 'package:mentoo/services/booking_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:intl/intl.dart';
import 'package:mentoo/services/mentor_working_time_service.dart';
import 'package:mentoo/widgets/alert_dialog.dart';
import 'package:mentoo/widgets/loading.dart';

class BookAppointment extends StatefulWidget {
  final int menteeId;
  final Mentor mentor;
  const BookAppointment({
    super.key,
    required this.mentor,
    required this.menteeId,
  });

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  bool _loading = true;
  bool bookingSuccess = false;
  List<MentorWorkingTime> _mentorWorkingTime = [];
  TimeOfDay _time = const TimeOfDay(hour: 7, minute: 15);
  final BookingRequestModel _booking = BookingRequestModel();

  DateTime _date = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm aa');
  final TextEditingController _updateDate = TextEditingController();
  @override
  void initState() {
    _fetchMentorWorkingTime();
    _initBooking();
    super.initState();
  }

  _initBooking() {
    setState(() {
      _booking.mentorId = widget.mentor.mentorId;
      _booking.menteeId = widget.menteeId;
      _booking.totalCost = 0;
      _booking.status = "Scheduled";
      _booking.startTime = _date;
      _booking.duration = 60;
    });
  }

  void showDialogWidget(BuildContext context) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => bookingSuccess
            ? AlertPopup(
                icon: Image.asset("assets/images/booking_success.png"),
                title: "Sucess",
                message:
                    "Your appointment booking successfully completed. Mentor will accept you soon",
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

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2022, 10),
      lastDate: DateTime(2030, 7),
      helpText: 'Select a date',
    );
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
    if (newDate != null) {
      setState(() {
        _date = newDate
            .add(Duration(hours: newTime!.hour, minutes: newTime.minute));
      });
      _booking.startTime = _date;
    }
    _updateDate.value = TextEditingValue(text: formatter.format(_date));
  }

  _fetchMentorWorkingTime() async {
    _mentorWorkingTime = await MentorWorkingTimeService()
        .fetchMentorWorkingTime(widget.mentor.mentorId);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mentorInfo = widget.mentor.user;
    var listDay = "";
    for (MentorWorkingTime day in _mentorWorkingTime) {
      listDay += "${day.dayOfWeek.toString().substring(0, 3)} - ";
    }
    listDay =
        listDay.isNotEmpty ? listDay.substring(0, listDay.length - 3) : "";
    var timeOfDay = _mentorWorkingTime.isNotEmpty
        ? "${_mentorWorkingTime.first.startTime.hour.toString().padLeft(2, '0')}:${_mentorWorkingTime.first.startTime.minute.toString().padLeft(2, '0')} - ${_mentorWorkingTime.first.endTime.hour.toString().padLeft(2, '0')}:${_mentorWorkingTime.first.endTime.minute.toString().padLeft(2, '0')}"
        : "";
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Get.back();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: AppFonts.medium(30, AppColors.mDarkPurple),
          title: const Text(
            'Book appointment',
          ),
        ),
        body: _loading
            ? const Loading()
            : Padding(
                padding: EdgeInsets.only(
                    left: AppCommon.screenWidthUnit(context),
                    right: AppCommon.screenWidthUnit(context)),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 90,
                          child: Row(children: [
                            mentorInfo.photo.replaceAll(" ", "").isEmpty
                                ? const CircleAvatar(
                                    backgroundImage: AssetImage(
                                      "assets/images/profile.png",
                                    ),
                                    radius: 40,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      mentorInfo.photo,
                                    ),
                                    radius: 40,
                                  ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mentorInfo.name,
                                  style: AppFonts.medium(24, Colors.black),
                                ),
                                Row(
                                  children: [
                                    mentorInfo.jobs!.isNotEmpty
                                        ? SizedBox(
                                            width: 150,
                                            child: RichText(
                                                text: TextSpan(
                                                    text: mentorInfo
                                                        .jobs!.first.role,
                                                    style: AppFonts.regular(
                                                        12, Colors.black),
                                                    children: [
                                                  TextSpan(
                                                      text: ", ",
                                                      style: AppFonts.regular(
                                                          12, Colors.black),
                                                      children: [
                                                        TextSpan(
                                                          text: mentorInfo.jobs!
                                                              .first.company,
                                                          style:
                                                              AppFonts.regular(
                                                                  12,
                                                                  Colors.black),
                                                        )
                                                      ])
                                                ])),
                                          )
                                        : const SizedBox(),
                                    SizedBox(
                                      width:
                                          mentorInfo.jobs!.isNotEmpty ? 10 : 0,
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
                                              14, Colors.black),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ]),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Working time",
                          style: AppFonts.bold(25, AppColors.mDarkPurple),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_today_outlined,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              listDay,
                              style: AppFonts.regular(14, Colors.black),
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
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              timeOfDay,
                              style: AppFonts.regular(14, Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                          child: SizedBox(
                            width: 300,
                            child: Divider(
                              color: AppColors.mGray,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Time',
                            style: AppFonts.bold(25, AppColors.mDarkPurple),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 46,
                          child: Center(
                            child: TextFormField(
                              decoration: InputDecoration(
                                suffixIconColor: AppColors.mDarkPurple,
                                contentPadding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                filled: true,
                                fillColor: AppColors.mBackground,
                                labelStyle:
                                    AppFonts.medium(16, AppColors.mDarkPurple),
                                hintText: formatter.format(_date),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: const UnderlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 20)),
                                suffixIcon: const Icon(Icons.calendar_month),
                              ),
                              readOnly: true,
                              onTap: () => _selectDate(),
                              // ignore: avoid_print
                              onChanged: (value) => print(value),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Duration',
                            style: AppFonts.bold(25, AppColors.mDarkPurple),
                            children: const <TextSpan>[
                              TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 46,
                          child: DropdownButtonFormField(
                            //icon: const Icon(Icons.expand_more),
                            iconEnabledColor: AppColors.mDarkPurple,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 20)),
                              contentPadding:
                                  EdgeInsets.only(left: 10, right: 10),
                              filled: true,
                              fillColor: AppColors.mBackground,
                            ),
                            dropdownColor: Colors.white,
                            value: "60 minutes",
                            items: <String>['60 minutes', '30 minutes']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              if (value != null) {
                                _booking.duration = int.parse(
                                    value.substring(0, value.length - 8));
                              }
                            },
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Text(
                        //   "Message",
                        //   style: AppFonts.bold(25, AppColors.mDarkPurple),
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextField(
                        //   cursorColor: AppColors.mDarkPurple,
                        //   keyboardType: TextInputType.multiline,
                        //   minLines: 5, //Normal textInputField will be displayed
                        //   maxLines:
                        //       5, // when user presses enter it will adapt to it
                        //   decoration: InputDecoration(
                        //       hintText: "Type your message",
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: const BorderRadius.all(
                        //             Radius.circular(5.0)),
                        //         borderSide: BorderSide(
                        //           color: AppColors.mDarkPurple,
                        //         ),
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: const BorderRadius.all(
                        //             Radius.circular(5.0)),
                        //         borderSide: BorderSide(
                        //           color: AppColors.mDarkPurple,
                        //         ),
                        //       ),
                        //       border: OutlineInputBorder(
                        //           borderRadius: BorderRadius.circular(5),
                        //           borderSide: BorderSide(
                        //               color: AppColors.mDarkPurple,
                        //               width: 20))),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Appointment type",
                          style: AppFonts.bold(25, AppColors.mDarkPurple),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: 56,
                            decoration: const BoxDecoration(
                                color: AppColors.mBackground,
                                //borderRadius: BorderRadius.circular(5),
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.mDarkPurple))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset("assets/images/google_meet.png"),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Google Meet",
                                  style: AppFonts.regular(
                                      18, AppColors.mDarkPurple),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mLightPurple,
                              fixedSize: const Size(390, 46),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              bookingSuccess =
                                  await BookingServivce().postBooking(_booking);
                              // ignore: use_build_context_synchronously
                              showDialogWidget(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text('Book',
                                    style: AppFonts.medium(
                                      16,
                                      Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                ),
              ));
  }
}
