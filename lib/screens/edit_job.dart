import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

class EditJob extends StatefulWidget {
  const EditJob({super.key});

  @override
  State<EditJob> createState() => _EditJobState();
}

class _EditJobState extends State<EditJob> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Text(
          "Edit job",
          style: AppFonts.medium(24, AppColors.mDarkPurple),
        ),
        leading: BackButton(
          color: AppColors.mDarkPurple,
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Company',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 46,
                child: TextFormField(
                  initialValue: "Shopee",
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
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Role',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 46,
                child: TextFormField(
                  initialValue: "Marketer",
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
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 7,
                maxLines: 10,
                initialValue: "Type your message",
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                      color: AppColors.mDarkPurple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                      color: AppColors.mDarkPurple,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  filled: true,
                  // fillColor: AppColors.grayColor,
                  // focusColor: AppColors.grayColor,
                  // hoverColor: AppColors.grayColor,
                  //labelText: lable,
                  labelStyle: AppFonts.medium(16, AppColors.mText),
                  //errorText: 'Error message',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                //initialValue: "Datetime",
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                      color: AppColors.mDarkPurple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                      color: AppColors.mDarkPurple,
                    ),
                  ),
                  label: const Text("From to"),
                  labelStyle: TextStyle(color: AppColors.mDarkPurple),
                  contentPadding: const EdgeInsets.only(left: 10),
                  filled: true,
                  // fillColor: AppColors.grayColor,
                  // labelStyle: AppFonts.medium(16),
                  hintText: formatter.format(DateTime.now()),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(color: Colors.blue, width: 20)),
                ),
                readOnly: true,
                onTap: () => _selectDate(),
                // ignore: avoid_print
                onChanged: (value) => print(value),
              ),
              SizedBox(
                height: 320,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mLightPurple,
                  fixedSize: const Size(400, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () => {},
                child: Text('Save',
                    style: AppFonts.medium(
                      20,
                      Colors.white,
                    )),
              ),
            ]),
      ),
    );
  }
}
