import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: SizedBox(
              height: 1000,
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
                      height: 46,
                      child: TextFormField(
                        initialValue: "Hoang Michael",
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
                      height: 20,
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
                      height: 46,
                      child: TextFormField(
                        initialValue: "31",
                        keyboardType: TextInputType.number,
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
                      height: 20,
                    ),
                    Text('About you',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 7,
                      maxLines: 10,
                      initialValue: "Type your message",
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
                      height: 20,
                    ),
                    Text('Jobs',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              visualDensity: VisualDensity(vertical: -4),
                              leading: Icon(
                                Icons.check_box_outlined,
                                color: AppColors.mDarkPurple,
                              ),
                              title: Text('Marketer at Shoppe'),
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
                            "Add job",
                            style: AppFonts.medium(18, AppColors.mDarkPurple),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Education',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              visualDensity: VisualDensity(vertical: -4),
                              leading: Icon(
                                Icons.check_box_outlined,
                                color: AppColors.mDarkPurple,
                              ),
                              title: Text('Study at FPT University'),
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
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mLightPurple,
                        fixedSize: const Size(400, 48),
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
                    ),
                  ]),
            ),
          ),
        ));
  }
}
