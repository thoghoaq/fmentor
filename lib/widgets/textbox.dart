import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

class PrimaryTextBox extends StatelessWidget {
  const PrimaryTextBox({
    Key? key,
    required this.textBoxHeight,
    required this.textBoxValue,
  }) : super(key: key);

  final double textBoxHeight;
  final String textBoxValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: textBoxHeight,
      child: TextFormField(
        initialValue: textBoxValue,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
    );
  }
}
