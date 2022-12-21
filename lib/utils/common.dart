import 'package:flutter/material.dart';

import '../screens/choose_major.dart';

class AppCommon {
  static double screenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static navigateToChooseMajor(context) {
    return Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const ChooseMajor()));
  }
}
