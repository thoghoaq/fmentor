import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';

@immutable
class AppFonts {
  static String fontFamily = 'Roboto';
  // ignore: non_constant_identifier_names
  static TextStyle medium(double size) {
    return TextStyle(
        color: AppColors.mText,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w900,
        fontSize: size);
  }

  static TextStyle regular(double size) {
    return TextStyle(
        color: AppColors.mText,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w100,
        fontSize: size);
  }

  const AppFonts();
}
