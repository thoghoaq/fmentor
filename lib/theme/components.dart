import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';

class AppComponents {
  const AppComponents();

  //social Button sign in
  static ElevatedButton socialButton(var icon, var label) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          fixedSize: const Size(288, 40),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: const BorderSide(color: Colors.black, width: sqrt1_2)),
        ),
        onPressed: () => {},
        icon: icon,
        label: label);
  }

  static ElevatedButton generalButton(var label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mLightPurple,
        fixedSize: const Size(288, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onPressed: () => {},
      child: label,
    );
  }
}
