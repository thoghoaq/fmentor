import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

class AlertPopup extends StatelessWidget {
  final dynamic icon;
  final dynamic title;
  final dynamic message;
  final List<dynamic>? buttons;
  const AlertPopup({
    this.icon,
    this.title,
    this.message,
    this.buttons,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      alignment: Alignment.center,
      contentPadding: const EdgeInsets.all(30),
      insetPadding: const EdgeInsets.all(30),
      title: Text(
        title,
        style: AppFonts.medium(30, AppColors.mDarkPurple),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: buttons != null
          ? <Widget>[
              Center(
                child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    width: 300,
                    height: 46,
                    decoration: BoxDecoration(
                        color: AppColors.mLightPurple,
                        borderRadius: BorderRadius.circular(30)),
                    child: buttons?[0]),
              ),
            ]
          : null,
    );
  }
}
