import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/button.dart';
import 'package:mentoo/widgets/textbox.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    var textBoxHeight = AppCommon.screenHeightUnit(context) * 0.75;
    var labelTextBoxSpace = AppCommon.screenHeightUnit(context) * 0.1;
    var itemCount = 5;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          title: Text(
            "Edit profile",
            style: AppFonts.medium(24, AppColors.mDarkPurple),
          ),
          leading: BackButton(
            color: AppColors.mDarkPurple,
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text('Fullname',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('*',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            PrimaryTextBox(
                textBoxHeight: textBoxHeight, textBoxValue: "Hoang Michael"),
            SizedBox(
              height: AppCommon.screenHeightUnit(context) * 0.2,
            ),
            Row(
              children: [
                Text('Age',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text('*',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            PrimaryTextBox(textBoxHeight: textBoxHeight, textBoxValue: "31"),
            SizedBox(
              height: AppCommon.screenHeightUnit(context) * 0.2,
            ),
            const Text('About you',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: labelTextBoxSpace,
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 7,
              maxLines: 10,
              initialValue: "Type your message",
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(
                    color: AppColors.mDarkPurple,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(
                    color: AppColors.mDarkPurple,
                  ),
                ),
                contentPadding: const EdgeInsets.all(10),
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
            SizedBox(
              height: AppCommon.screenHeightUnit(context) * 0.2,
            ),
            const Text('Jobs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: AppCommon.screenHeightUnit(context) * 0.8 * itemCount,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      leading: Icon(
                        Icons.check_box_outlined,
                        color: AppColors.mDarkPurple,
                      ),
                      title: const Text('Marketer at Shoppe'),
                      subtitle: Divider(
                        thickness: 2,
                        color: AppColors.mDarkPurple,
                      ),
                      trailing: Icon(
                        Icons.edit_outlined,
                        color: AppColors.mDarkPurple,
                      ),
                    );
                  }),
            ),
            Center(
              child: Container(
                height: AppCommon.screenHeightUnit(context) * 0.5,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    "Add job",
                    style: AppFonts.medium(18, AppColors.mDarkPurple),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: labelTextBoxSpace,
            ),
            const Text('Education',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(
              height: AppCommon.screenHeightUnit(context) * 0.8 * itemCount,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      visualDensity: const VisualDensity(vertical: -4),
                      leading: Icon(
                        Icons.check_box_outlined,
                        color: AppColors.mDarkPurple,
                      ),
                      title: const Text('Study at FPT University'),
                      subtitle: Divider(
                        thickness: 2,
                        color: AppColors.mDarkPurple,
                      ),
                      trailing: Icon(
                        Icons.edit_outlined,
                        color: AppColors.mDarkPurple,
                      ),
                    );
                  }),
            ),
            Center(
              child: Container(
                height: 36,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    "Add School",
                    style: AppFonts.medium(18, AppColors.mDarkPurple),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: labelTextBoxSpace * 3,
            ),
            const PrimaryButton()
          ]),
        ));
  }
}
