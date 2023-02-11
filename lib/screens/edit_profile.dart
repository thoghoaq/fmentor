import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/request/user_request_model.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/screens/edit_job.dart';
import 'package:mentoo/screens/home_page.dart';
import 'package:mentoo/screens/main_home_page.dart';
import 'package:mentoo/services/mentee_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/alert_dialog.dart';
import 'package:mentoo/widgets/button.dart';
import 'package:mentoo/widgets/loading.dart';
import 'package:mentoo/widgets/textbox.dart';

import '../models/mentee.dart' as Mentee;

class EditProfile extends StatefulWidget {
  EditProfile({super.key, this.menteeId});
  int? menteeId;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late Mentee.Mentee _mentee;
  User? _user;
  String? _menteeId;
  late String name;
  String? decription;
  int? age;

  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _user = (await UserService().getUser());
    _menteeId = await MenteeService().getMenteeByUserId(_user!.userId);
    _mentee = (await MenteeService().getMenteeById(int.parse(_menteeId!)))!;
    name = _user!.name;
    setState(() {
      if (_mentee != null) isLoaded = true;
    });
  }

  void _reload() {
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showDialogWidget(BuildContext context, String error) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertPopup(
              icon: Icon(
                Icons.error,
                size: 200,
                color: Colors.red,
              ),
              title: "Opps, Failed",
              message: error,
              buttons: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: Text(
                    'Try again',
                    style: AppFonts.medium(18, Colors.white),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    var textBoxHeight = AppCommon.screenHeightUnit(context) * 0.75;
    var labelTextBoxSpace = AppCommon.screenHeightUnit(context) * 0.1;
    var itemCount = 5;
    return !isLoaded
        ? Loading()
        : Scaffold(
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
                onPressed: () {
                  Get.to(MainPage(
                    isMentor: 0,
                    initialPage: 2,
                    userId: _user!.userId,
                  ));
                },

              ),
            ),
            body: ListView(children: [
              Padding(
                padding:
                    EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Fullname',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
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
                      SizedBox(
                        height: textBoxHeight,
                        child: TextFormField(
                          onChanged: (value) => name = value,
                          initialValue: _user!.name,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(
                                color: AppColors.mDarkPurple,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppCommon.screenHeightUnit(context) * 0.2,
                      ),
                      Row(
                        children: [
                          Text('Age',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
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
                      SizedBox(
                        height: textBoxHeight,
                        child: TextFormField(
                          //keyboardType: TextInputType.number,
                          onChanged: (value) => age = int.parse(value),
                          initialValue:
                              _user!.age == 0 ? null : _user!.age.toString(),
                          decoration: InputDecoration(
                            hintText: _user!.age == 0 ? "Enter your age" : null,
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              borderSide: BorderSide(
                                color: AppColors.mDarkPurple,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppCommon.screenHeightUnit(context) * 0.2,
                      ),
                      const Text('About you',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: labelTextBoxSpace,
                      ),
                      TextFormField(
                        onChanged: (value) => decription = value,
                        keyboardType: TextInputType.multiline,
                        minLines: 7,
                        maxLines: 10,
                        initialValue: _user!.description,
                        decoration: InputDecoration(
                          hintText: _user!.description == " "
                              ? "Type your message"
                              : null,
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                              color: AppColors.mDarkPurple,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppCommon.screenHeightUnit(context) * 0.2,
                      ),
                      const Text('Jobs',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20,
                      ),
                      _user!.jobs != null && !_user!.jobs!.isEmpty
                          ? SizedBox(
                              height: AppCommon.screenHeightUnit(context) *
                                  0.8 *
                                  _user!.jobs!.length,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _user!.jobs!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      visualDensity:
                                          const VisualDensity(vertical: -4),
                                      leading: Icon(
                                        Icons.check_box_outlined,
                                        color: AppColors.mDarkPurple,
                                      ),
                                      title: Text(_user!.jobs![index].role +
                                          " at " +
                                          _user!.jobs![index].company),
                                      subtitle: Divider(
                                        thickness: 2,
                                        color: AppColors.mDarkPurple,
                                      ),
                                      trailing: InkWell(
                                        onTap: () => Get.to(EditJob(
                                          userId: _user!.userId,
                                          id: _user!.jobs![index].jobId,
                                        )),
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: AppColors.mDarkPurple,
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Container(
                              child: Text("There is no data about jobs!")),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => Get.to(EditJob(
                          isAdd: true,
                          userId: _user!.userId,
                        )),
                        child: Center(
                          child: Container(
                            height: AppCommon.screenHeightUnit(context) * 0.5,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                "Add job",
                                style:
                                    AppFonts.medium(18, AppColors.mDarkPurple),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: labelTextBoxSpace,
                      ),
                      const Text('Educations',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 20,
                      ),
                      !_user!.educations!.isEmpty
                          ? SizedBox(
                              height: AppCommon.screenHeightUnit(context) *
                                  0.8 *
                                  _user!.educations!.length,
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _user!.educations!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                      visualDensity:
                                          const VisualDensity(vertical: -4),
                                      leading: Icon(
                                        Icons.check_box_outlined,
                                        color: AppColors.mDarkPurple,
                                      ),
                                      title: Text(
                                          _user!.educations![index].major +
                                              ' at ' +
                                              _user!.educations![index].school),
                                      subtitle: Divider(
                                        thickness: 2,
                                        color: AppColors.mDarkPurple,
                                      ),
                                      trailing: InkWell(
                                        onTap: () => Get.to(EditJob(
                                          isAdd: false,
                                          userId: _user!.userId,
                                          type: "Education",
                                          id: _user!
                                              .educations![index].educationId,
                                        )),
                                        child: Icon(
                                          Icons.edit_outlined,
                                          color: AppColors.mDarkPurple,
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          : Container(
                              child: Text(
                              "There is no data about educations!",
                            )),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => Get.to(EditJob(
                          isAdd: true,
                          userId: _user!.userId,
                          type: "Education",
                        )),
                        child: Center(
                          child: Container(
                            height: AppCommon.screenHeightUnit(context) * 0.5,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                "Add School",
                                style:
                                    AppFonts.medium(18, AppColors.mDarkPurple),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: labelTextBoxSpace * 3,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mLightPurple,
                          fixedSize: Size(
                              AppCommon.screenWidthUnit(context) * 11,
                              AppCommon.screenHeightUnit(context) * 0.75),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            UserRequestModel user = UserRequestModel(
                                name: name, age: age, description: decription);
                            await UserService().updateUser(user, _user!.userId);
                            var user1 =
                                await UserService().getUserById(_user!.userId);
                            await UserService().saveUser(user1!);
                            await UserService().getUser();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(
                                        isMentor: 0,
                                        initialPage: 2,
                                        userId: user1.userId,
                                      )),
                            );
                          } catch (error) {
                            showDialogWidget(context, error.toString());
                          }
                        },
                        child: Text('Save',
                            style: AppFonts.medium(
                              20,
                              Colors.white,
                            )),
                      )
                    ]),
              ),
            ]),
          );
  }
}
