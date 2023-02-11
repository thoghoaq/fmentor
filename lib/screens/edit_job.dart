import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentoo/models/mentor.dart';
import 'package:mentoo/models/request/education_request_model.dart';
import 'package:mentoo/models/request/job_request_model.dart';
import 'package:mentoo/screens/edit_profile.dart';
import 'package:mentoo/services/education_service.dart';
import 'package:mentoo/services/job_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/alert_dialog.dart';
import 'package:mentoo/widgets/loading.dart';

class EditJob extends StatefulWidget {
  EditJob(
      {super.key,
      this.isAdd = false,
      required this.userId,
      this.id,
      this.type = "Job"});
  bool isAdd;
  int userId;
  int? id;
  String type;

  @override
  State<EditJob> createState() => _EditJobState(type);
}

class _EditJobState extends State<EditJob> {
  DateTime _date = DateTime.now();
  bool isChecked = false;
  late String company;
  late String role;
  DateTime startDate = DateTime.now();
  DateTime? endDate;
  late String error;
  Job? job;
  Education? education;

  var isLoaded = false;

  _EditJobState(type) {
    company = type == "Job" ? "Shoppe" : "FPT";
    role = type == "Job" ? "Marketer" : "Software Engineering";
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    if (!widget.isAdd) {
      if (widget.type == "Job") {
        job = await JobService().getJob(widget.id!);
        if (job != null) {
          isChecked = job!.isCurrent == 1 ? true : false;
          startDate = job!.startDate;
          if (job!.endDate != null) endDate = job!.endDate;
          // else
          //   endDate = startDate.add(Duration(days: 1));
          setState(() {
            isLoaded = true;
          });
        }
      } else {
        education = await EducationService().getEducation(widget.id!);
        if (education != null) {
          isChecked = education!.isCurrent == 1 ? true : false;
          startDate = education!.startDate;
          if (education!.endDate != null) endDate = education!.endDate;
          // else
          //   endDate = startDate.add(Duration(days: 1));
          setState(() {
            isLoaded = true;
          });
        }
      }
    } else {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final TextEditingController _updateDate = TextEditingController();
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1900, 10),
      lastDate: DateTime(2030, 7),
      helpText: 'Select a date',
    );

    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
    _updateDate.value = TextEditingValue(text: formatter.format(_date));
  }

  void showDialogWidget(BuildContext context, String error) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertPopup(
              icon: Icon(
                Icons.error,
                size: 200,
                color: Colors.red,
              ),
              title: "Opps, Failed",
              message: error,
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
  Widget build(BuildContext context) {
    var textBoxHeight = AppCommon.screenHeightUnit(context) * 0.75;
    var labelTextBoxSpace = AppCommon.screenHeightUnit(context) * 0.1;

    return !isLoaded
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: false,
              elevation: 0,
              title: Text(
                widget.isAdd && widget.type == "Job"
                    ? "Add job"
                    : (widget.type != "Job" && widget.isAdd
                        ? "Add education"
                        : (!widget.isAdd && widget.type == "Job"
                            ? "Edit job"
                            : "Edit education")),
                style: AppFonts.medium(24, AppColors.mDarkPurple),
              ),
              leading: BackButton(
                color: AppColors.mDarkPurple,
                onPressed: () {
                  Get.to(EditProfile());
                },
              ),
            ),
            body: Padding(
              padding:
                  EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.5),
              child: Stack(children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        activeColor: AppColors.mDarkPurple,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          widget.type == "Job"
                              ? "Current job"
                              : "Current education",
                          style: TextStyle(fontSize: 16),
                        ),
                        value: isChecked,
                        onChanged: (newValue) {
                          setState(() {
                            endDate = startDate.add(Duration(days: 1));
                            isChecked = newValue!;
                          });
                        },
                      ),
                      Text(widget.type == "Job" ? 'Company' : "School",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: labelTextBoxSpace,
                      ),
                      SizedBox(
                        height: textBoxHeight,
                        child: TextFormField(
                          onChanged: (value) => company = value,
                          initialValue: job == null && education == null
                              ? company
                              : (job != null
                                  ? job!.company
                                  : (education != null
                                      ? education!.school
                                      : "")),
                          decoration: InputDecoration(
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
                            contentPadding: const EdgeInsets.only(left: 10),
                            filled: true,
                            // fillColor: AppColors.grayColor,
                            // focusColor: AppColors.grayColor,
                            // hoverColor: AppColors.grayColor,
                            //labelText: lable,
                            labelStyle: AppFonts.medium(16, AppColors.mText),
                            //errorText: 'Error message',
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppCommon.screenHeightUnit(context) * 0.3,
                      ),
                      Text(widget.type == "Job" ? 'Role' : "Major",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: labelTextBoxSpace,
                      ),
                      SizedBox(
                        height: textBoxHeight,
                        child: TextFormField(
                          onChanged: (value) => role = value,
                          initialValue: job == null && education == null
                              ? role
                              : (job != null
                                  ? job!.role
                                  : (education != null
                                      ? education!.major
                                      : "")),
                          decoration: InputDecoration(
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
                            contentPadding: const EdgeInsets.only(left: 10),
                            filled: true,
                            // fillColor: AppColors.grayColor,
                            // focusColor: AppColors.grayColor,
                            // hoverColor: AppColors.grayColor,
                            //labelText: lable,
                            labelStyle: AppFonts.medium(16, AppColors.mText),
                            //errorText: 'Error message',
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: labelTextBoxSpace,
                      ),
                      // TextFormField(
                      //   onChanged: (value) => description = value,
                      //   keyboardType: TextInputType.multiline,
                      //   minLines: 7,
                      //   maxLines: 10,
                      //   initialValue: "Description",
                      //   decoration: InputDecoration(
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius:
                      //           const BorderRadius.all(Radius.circular(5.0)),
                      //       borderSide: BorderSide(
                      //         color: AppColors.mDarkPurple,
                      //       ),
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius:
                      //           const BorderRadius.all(Radius.circular(5.0)),
                      //       borderSide: BorderSide(
                      //         color: AppColors.mDarkPurple,
                      //       ),
                      //     ),
                      //     contentPadding: const EdgeInsets.all(10),
                      //     filled: true,
                      //     // fillColor: AppColors.grayColor,
                      //     // focusColor: AppColors.grayColor,
                      //     // hoverColor: AppColors.grayColor,
                      //     //labelText: lable,
                      //     labelStyle: AppFonts.medium(16, AppColors.mText),
                      //     //errorText: 'Error message',
                      //     border: const OutlineInputBorder(
                      //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: labelTextBoxSpace * 2,
                      // ),
                      TextFormField(
                        //initialValue: "Datetime",
                        decoration: InputDecoration(
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
                          label: const Text("Start"),
                          labelStyle: TextStyle(color: AppColors.mDarkPurple),
                          contentPadding: const EdgeInsets.only(left: 10),
                          filled: true,
                          // fillColor: AppColors.grayColor,
                          // labelStyle: AppFonts.medium(16),
                          hintText: formatter.format(_date),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 20)),
                        ),
                        readOnly: true,
                        onTap: () {
                          _selectDate();
                        },
                        // ignore: avoid_print
                        onChanged: (value) => startDate = DateTime.parse(value),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      !isChecked
                          ? TextFormField(
                              //initialValue: "Datetime",
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  borderSide: BorderSide(
                                    color: AppColors.mDarkPurple,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  borderSide: BorderSide(
                                    color: AppColors.mDarkPurple,
                                  ),
                                ),
                                label: const Text("End"),
                                labelStyle:
                                    TextStyle(color: AppColors.mDarkPurple),
                                contentPadding: const EdgeInsets.only(left: 10),
                                filled: true,
                                // fillColor: AppColors.grayColor,
                                // labelStyle: AppFonts.medium(16),
                                hintText: formatter.format(_date),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 20)),
                              ),
                              readOnly: true,
                              onTap: () {
                                _selectDate();
                              },
                              // ignore: avoid_print
                              onChanged: (value) =>
                                  endDate = DateTime.parse(value),
                            )
                          : Container(),
                      SizedBox(
                        height: AppCommon.screenHeightUnit(context),
                      ),
                    ]),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mLightPurple,
                      fixedSize: Size(AppCommon.screenWidthUnit(context) * 11,
                          AppCommon.screenHeightUnit(context) * 0.75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () async {
                      if (widget.type == "Job") {
                        JobRequestModel job = JobRequestModel(
                            userId: widget.userId,
                            company: company,
                            role: role,
                            startDate: startDate,
                            endDate: endDate,
                            isCurrent: isChecked);
                        try {
                          if (widget.isAdd)
                            await JobService().addJob(job);
                          else
                            await JobService().editJob(job, widget.id!);
                          var user =
                              await UserService().getUserById(widget.userId);
                          await UserService().saveUser(user!);
                          await UserService().getUser();
                          Get.to(EditProfile());
                        } catch (e) {
                          showDialogWidget(context, e.toString());
                        }
                      } else {
                        EducationRequestModel job = EducationRequestModel(
                            userId: widget.userId,
                            school: company,
                            major: role,
                            startDate: startDate,
                            endDate: endDate,
                            isCurrent: isChecked);
                        try {
                          if (widget.isAdd)
                            await EducationService().addEducation(job);
                          else
                            await EducationService()
                                .updateEducation(job, widget.id!);
                          var user =
                              await UserService().getUserById(widget.userId);
                          await UserService().saveUser(user!);
                          await UserService().getUser();
                          Get.to(EditProfile());
                        } catch (e) {
                          showDialogWidget(context, e.toString());
                        }
                      }
                    },
                    child: Text('Save',
                        style: AppFonts.medium(
                          20,
                          Colors.white,
                        )),
                  ),
                ),
              ]),
            ),
          );
  }
}
