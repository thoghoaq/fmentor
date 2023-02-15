import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mLightPurple,
        fixedSize: Size(AppCommon.screenWidthUnit(context) * 11,
            AppCommon.screenHeightUnit(context) * 0.75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onPressed: () => {},
      child: Text('Save',
          style: AppFonts.medium(
            20,
            Colors.white,
          )),
    );
  }
}
