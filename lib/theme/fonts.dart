import 'package:flutter/material.dart';

@immutable
class AppFonts {
  static String fontFamily = 'Roboto';
  // ignore: non_constant_identifier_names
  static TextStyle medium(double size, Color color) {
    return TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: size);
  }

  static TextStyle regular(double size, Color color) {
    return TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w300,
        fontSize: size);
  }

  static TextStyle bold(double size, Color color) {
    return TextStyle(
        color: color,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w900,
        fontSize: size);
  }

  const AppFonts();
}
