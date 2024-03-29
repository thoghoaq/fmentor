import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/button.dart';
import 'package:mentoo/widgets/textbox.dart';

class EditEducation extends StatefulWidget {
  const EditEducation({super.key});

  @override
  State<EditEducation> createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {
  DateTime _date = DateTime(2001, 11, 01);
  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  final TextEditingController _updateDate = TextEditingController();
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
    _updateDate.value = TextEditingValue(text: formatter.format(_date));
  }

  @override
  Widget build(BuildContext context) {
    var textBoxHeight = AppCommon.screenHeightUnit(context) * 0.75;
    var labelTextBoxSpace = AppCommon.screenHeightUnit(context) * 0.1;
    return Padding(
      padding: EdgeInsets.all(AppCommon.screenWidthUnit(context) * 0.5),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          title: Text(
            "Edit education",
            style: AppFonts.medium(24, AppColors.mDarkPurple),
          ),
          leading: BackButton(
            color: AppColors.mDarkPurple,
            onPressed: () {},
          ),
        ),
        body: Stack(children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('School',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: labelTextBoxSpace,
                ),
                PrimaryTextBox(
                    textBoxHeight: textBoxHeight, textBoxValue: "Shopee"),
                SizedBox(
                  height: AppCommon.screenHeightUnit(context) * 0.3,
                ),
                const Text('Major',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: labelTextBoxSpace,
                ),
                PrimaryTextBox(
                    textBoxHeight: textBoxHeight, textBoxValue: "Marketing"),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: textBoxHeight,
                  child: TextFormField(
                    //initialValue: "Datetime",
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                          color: AppColors.mDarkPurple,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: AppColors.mDarkPurple,
                        ),
                      ),
                      label: const Text("From to"),
                      labelStyle: const TextStyle(color: AppColors.mDarkPurple),
                      contentPadding: const EdgeInsets.only(left: 10),
                      filled: true,
                      // fillColor: AppColors.grayColor,
                      // labelStyle: AppFonts.medium(16),
                      hintText: formatter.format(DateTime.now()),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 20)),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(),
                    // ignore: avoid_print
                    onChanged: (value) => print(value),
                  ),
                ),
                SizedBox(
                  height: AppCommon.screenHeightUnit(context),
                ),
              ]),
          const Align(
            alignment: Alignment.bottomCenter,
            child: PrimaryButton(),
          ),
        ]),
      ),
    );
  }
}
