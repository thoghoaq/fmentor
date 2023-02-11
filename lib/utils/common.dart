import 'package:flutter/material.dart';

import '../screens/choose_major.dart';
import '../common/constants.dart';

class AppCommon {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidthUnit(BuildContext context) {
    return MediaQuery.of(context).size.width * Constants.SCREEN_DIVIDE_VALUE;
  }

  static double screenHeightUnit(BuildContext context) {
    return MediaQuery.of(context).size.height * Constants.SCREEN_DIVIDE_VALUE;
  }

  // static navigateToChooseMajor(context) {
  //   return Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (BuildContext context) => const ChooseMajor()));
  // }
}
