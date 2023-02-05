import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:intl/intl.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({super.key});

  @override
  State<BookAppointment> createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  bool bookingSuccess = false;
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  DateTime _date = DateTime(2022, 10, 31, 4, 30);
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm aa');
  final TextEditingController _updateDate = TextEditingController();
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2023, 1),
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
    }
    _updateDate.value = TextEditingValue(text: formatter.format(_date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Book appointment',
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.3),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  child: Row(children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profile.png"),
                      radius: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hoang Michael",
                          style: AppFonts.medium(24, Colors.black),
                        ),
                        Row(
                          children: [
                            Text(
                              "Marketer, Shopee",
                              style: AppFonts.regular(14, Colors.black),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 70,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: AppColors.mLightPurple,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all()),
                              child: Center(
                                child: Text(
                                  'Mentor',
                                  style: AppFonts.regular(14, Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ]),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Working time",
                  style: AppFonts.bold(25, AppColors.mDarkPurple),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Monday - Friday",
                      style: AppFonts.regular(14, Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.schedule_outlined,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "9:00 AM - 20:00 PM",
                      style: AppFonts.regular(14, Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Divider(
                      color: AppColors.mGray,
                    ),
                  ),
                ),
                SizedBox(
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
                              fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                ),
                SizedBox(
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
                        labelStyle: AppFonts.medium(16, AppColors.mDarkPurple),
                        hintText: formatter.format(_date),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const UnderlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 20)),
                        suffixIcon: const Icon(Icons.calendar_month),
                      ),
                      readOnly: true,
                      onTap: () => _selectDate(),
                      // ignore: avoid_print
                      onChanged: (value) => print(value),
                    ),
                  ),
                ),
                SizedBox(
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
                              fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 46,
                  child: DropdownButtonFormField(
                    //icon: const Icon(Icons.expand_more),
                    iconEnabledColor: AppColors.mDarkPurple,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 20)),
                      contentPadding:
                          const EdgeInsets.only(left: 10, right: 10),
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
                    onChanged: (String? value) {},
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Message",
                  style: AppFonts.bold(25, AppColors.mDarkPurple),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  cursorColor: AppColors.mDarkPurple,
                  keyboardType: TextInputType.multiline,
                  minLines: 5, //Normal textInputField will be displayed
                  maxLines: 5, // when user presses enter it will adapt to it
                  decoration: InputDecoration(
                      hintText: "Type your message",
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: AppColors.mDarkPurple,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: AppColors.mDarkPurple,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                              color: AppColors.mDarkPurple, width: 20))),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Appointment type",
                  style: AppFonts.bold(25, AppColors.mDarkPurple),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 56,
                    decoration: BoxDecoration(
                        color: AppColors.mBackground,
                        //borderRadius: BorderRadius.circular(5),
                        border: Border(
                            bottom: BorderSide(color: AppColors.mDarkPurple))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset("assets/images/google_meet.png"),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Google Meet",
                          style: AppFonts.regular(18, AppColors.mDarkPurple),
                        )
                      ],
                    )),
                SizedBox(
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
                    onPressed: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => bookingSuccess
                          ? AlertPopup()
                          : AlertDialog(
                              icon:
                                  Image.asset("assets/images/booking_fail.png"),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              alignment: Alignment.center,
                              //contentPadding: EdgeInsets.all(20),
                              //insetPadding: EdgeInsets.all(20),
                              title: Text(
                                "Opps, Failed",
                                style:
                                    AppFonts.medium(30, AppColors.mDarkPurple),
                              ),
                              content: Text(
                                'Something wen\'t wrong',
                                textAlign: TextAlign.center,
                              ),
                              actions: <Widget>[
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        bottom: 20, left: 30, right: 30),
                                    width: 300,
                                    height: 46,
                                    decoration: BoxDecoration(
                                        color: AppColors.mLightPurple,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: Text(
                                        'Try again',
                                        style:
                                            AppFonts.medium(18, Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 20,
                        ),
                        SizedBox(
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
              ]),
        ));
  }
}

class AlertPopup extends StatelessWidget {
  const AlertPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Image.asset("assets/images/booking_success.png"),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      alignment: Alignment.center,
      contentPadding: EdgeInsets.all(30),
      insetPadding: EdgeInsets.all(30),
      title: Text(
        "Successful",
        style: AppFonts.medium(30, AppColors.mDarkPurple),
      ),
      content: Text(
        'Your appointment booking successfully completed. Mentor Hoang Michael will accept you soon',
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        Center(
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            width: 300,
            height: 46,
            decoration: BoxDecoration(
                color: AppColors.mLightPurple,
                borderRadius: BorderRadius.circular(30)),
            child: TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(
                'OK',
                style: AppFonts.medium(18, Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
