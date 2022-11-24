import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:filter_list/filter_list.dart';

class ChooseMajor extends StatefulWidget {
  const ChooseMajor({super.key});

  @override
  State<ChooseMajor> createState() => _ChooseMajorState();
}

class Major {
  final String? name;
  final String? avatar;
  Major({this.name, this.avatar});
}

List<Major> majorList = [
  Major(name: "Marketing", avatar: ""),
  Major(name: "UI/UX", avatar: ""),
  Major(name: "Business", avatar: ""),
  Major(name: "Hotel", avatar: ""),
  Major(name: "Software Engineering", avatar: ""),
  Major(name: "Human Resources", avatar: ""),
  Major(name: "Education", avatar: ""),
  Major(name: "Dietetics ", avatar: ""),
  Major(name: "Biomedical Engineering", avatar: ""),
  Major(name: "Forensic", avatar: ""),
  Major(name: "Speech-Language Pathology", avatar: ""),
  Major(name: "Graphic Design ", avatar: ""),
  Major(name: "Marketing", avatar: ""),
  Major(name: "UI/UX", avatar: ""),
  Major(name: "Business", avatar: ""),
  Major(name: "Hotel", avatar: ""),
  Major(name: "Software Engineering", avatar: ""),
  Major(name: "Human Resources", avatar: ""),
  Major(name: "Education", avatar: ""),
  Major(name: "Dietetics ", avatar: ""),
  Major(name: "Biomedical Engineering", avatar: ""),
  Major(name: "Forensic", avatar: ""),
  Major(name: "Speech-Language Pathology", avatar: ""),
  Major(name: "Graphic Design ", avatar: ""),
];

class _ChooseMajorState extends State<ChooseMajor> {
  List<Major>? selectedMajorList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        height: 1000,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset(
              'assets/images/logo.png',
              width: 100,
              height: 100,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Text('Mentoo',
                  style: AppFonts.bold(
                    50,
                    AppColors.mDarkPurple,
                  )),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text("Tell us what you're interested in",
                  style: AppFonts.medium(
                    20,
                    AppColors.mDarkPurple,
                  )),
            ),
          ),
          SizedBox(
            width: 350,
            height: 450,
            child: FilterListWidget<Major>(
              hideSearchField: true,
              hideHeader: true,
              hideSelectedTextCount: true,
              controlButtons: const [ControlButtonType.Reset],
              themeData: FilterListThemeData(
                context,
                wrapSpacing: 13,
                wrapAlignment: WrapAlignment.center,
                choiceChipTheme: ChoiceChipThemeData(
                  textStyle: AppFonts.bold(14, AppColors.mGray),
                  selectedTextStyle: AppFonts.bold(14, AppColors.mGray),
                  selectedBackgroundColor: AppColors.m_background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                        color: AppColors.mGrayStroke, width: sqrt1_2),
                  ),
                  selectedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Colors.white, width: sqrt1_2),
                  ),
                ),
                controlButtonBarTheme: ControlButtonBarThemeData(
                  context,
                  padding: const EdgeInsets.all(10.0),
                  controlButtonTheme: ControlButtonThemeData(
                    primaryButtonBackgroundColor: AppColors.mDarkPurple,
                    primaryButtonTextStyle: AppFonts.bold(16, Colors.white),
                    textStyle: AppFonts.medium(16, AppColors.mText),
                  ),
                  decoration: BoxDecoration(
                      // border: Border.all(color: AppColors.mGrayStroke),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                      color: AppColors.mPrimary,
                      shape: BoxShape.rectangle),
                ),
              ),
              listData: majorList,
              applyButtonText: 'Submit',
              selectedListData: selectedMajorList,
              onApplyButtonClick: (list) {
                // do something with list ..
              },
              choiceChipLabel: (item) {
                /// Used to display text on chip
                return item!.name;
              },
              validateSelectedItem: (list, val) {
                ///  identify if item is selected or not
                return list!.contains(val);
              },
              onItemSearch: (major, query) {
                /// When search query change in search bar then this method will be called
                ///
                /// Check if items contains query
                return major.name!.toLowerCase().contains(query.toLowerCase());
              },
            ),
          ),
        ]),
      ),
    );
  }
}
