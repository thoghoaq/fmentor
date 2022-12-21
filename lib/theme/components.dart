import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';

class AppComponents {
  //social Button sign in
  static ElevatedButton socialButton(var icon, var label, var function) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.white,
          fixedSize: const Size(288, 40),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: const BorderSide(color: Colors.black, width: sqrt1_2)),
        ),
        onPressed: function,
        icon: icon,
        label: label);
  }

  static ElevatedButton generalButton(var label, var function) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mLightPurple,
        fixedSize: const Size(288, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onPressed: function,
      child: label,
    );
  }

  const AppComponents();
}
