import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:filter_list/filter_list.dart';
import 'package:mentoo/utils/common.dart';

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
    double whiteSpace = AppCommon.screenHeight(context) * 0.1;
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        height: AppCommon.screenHeight(context),
        child: Column(
          children: [
            Header(whiteSpace: whiteSpace),
            ListMajors(selectedMajorList: selectedMajorList),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.whiteSpace,
  }) : super(key: key);

  final double whiteSpace;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(top: whiteSpace),
        child: Image.asset(
          'assets/images/logo.png',
          width: 100,
          height: 100,
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
              top: AppCommon.screenHeight(context) * 0.005,
              bottom: AppCommon.screenHeight(context) * 0.01),
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
          padding: EdgeInsets.only(
              top: AppCommon.screenHeight(context) * 0.01,
              bottom: AppCommon.screenHeight(context) * 0.01),
          child: Text("Tell us what you're interested in",
              style: AppFonts.medium(
                20,
                AppColors.mDarkPurple,
              )),
        ),
      ),
    ]);
  }
}

class ListMajors extends StatelessWidget {
  const ListMajors({
    Key? key,
    required this.selectedMajorList,
  }) : super(key: key);

  final List<Major>? selectedMajorList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppCommon.screenWidth(context),
      height: AppCommon.screenHeightUnit(context) * 7,
      child: FilterListWidget<Major>(
        hideSearchField: true,
        hideHeader: true,
        hideSelectedTextCount: true,
        controlButtons: const [ControlButtonType.Reset],
        themeData: FilterListThemeData(
          backgroundColor: Colors.white10,
          context,
          wrapSpacing: AppCommon.screenHeightUnit(context) * 0.2,
          wrapAlignment: WrapAlignment.center,
          choiceChipTheme: ChoiceChipThemeData(
            textStyle: AppFonts.bold(14, AppColors.mGray),
            selectedTextStyle: AppFonts.bold(14, AppColors.mGray),
            selectedBackgroundColor: AppColors.m_background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: AppColors.mGrayStroke, width: sqrt1_2),
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
    );
  }
}
