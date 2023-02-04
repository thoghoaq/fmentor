import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({super.key});

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  bool cancelAppointment = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.black,
            onPressed: () {},
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: AppFonts.medium(30, AppColors.mDarkPurple),
          title: const Text(
            'My Appointments',
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 48.0,
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 1)),
              ),
              child: TabBar(
                //padding: EdgeInsets.symmetric(horizontal: 20),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: AppColors.mLightPurple,
                    width: 2,
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorColor: AppColors.mLightPurple,
                labelStyle: AppFonts.medium(16, AppColors.mDarkPurple),
                unselectedLabelStyle: AppFonts.medium(16, AppColors.mGray),
                labelColor: AppColors.mDarkPurple,
                unselectedLabelColor: AppColors.mGrayStroke,
                tabs: [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Waiting'),
                  Tab(text: 'Completed'),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          //color: Colors.amber,
          padding: EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.3),
          child: TabBarView(
            children: [
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    height: 140,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/images/profile.png",
                            ),
                            radius: 45,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hoang Michale",
                                style: AppFonts.medium(18, Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Marketer, Shopee",
                                    style: AppFonts.regular(12, Colors.black),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: AppColors.mLightPurple,
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all()),
                                    child: Center(
                                      child: Text(
                                        'Mentor',
                                        style:
                                            AppFonts.regular(12, Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "31/10/2022 4:30 PM",
                                    style: AppFonts.regular(12, Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.schedule_outlined,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "60 minutes",
                                    style: AppFonts.regular(12, Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Google Meet - ",
                                    style: AppFonts.regular(12, Colors.black),
                                    children: [
                                      TextSpan(
                                        text: 'Happenning',
                                        style: AppFonts.medium(
                                            12, AppColors.mDarkPurple),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black12)),
                            child: Image.asset(
                              "assets/images/google_meet.png",
                              width: 35,
                              height: 35,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 250,
                        child: Divider(color: AppColors.mGray),
                      )
                    ]),
                  );
                },
              ),
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    height: 140,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/images/profile.png",
                            ),
                            radius: 45,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hoang Michale",
                                style: AppFonts.medium(18, Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Marketer, Shopee",
                                    style: AppFonts.regular(12, Colors.black),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: AppColors.mLightPurple,
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all()),
                                    child: Center(
                                      child: Text(
                                        'Mentor',
                                        style:
                                            AppFonts.regular(12, Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "31/10/2022 4:30 PM",
                                    style: AppFonts.regular(12, Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.schedule_outlined,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "60 minutes",
                                    style: AppFonts.regular(12, Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Google Meet - ",
                                    style: AppFonts.regular(12, Colors.black),
                                    children: [
                                      TextSpan(
                                        text: 'Schedule',
                                        style: AppFonts.medium(12, Colors.blue),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                        size: 100,
                                      ),
                                      iconPadding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      alignment: Alignment.center,
                                      contentPadding: EdgeInsets.all(30),
                                      //insetPadding: EdgeInsets.all(30),
                                      title: Text(
                                        "Are you want to cancel?",
                                        style: AppFonts.medium(
                                            20, AppColors.mDarkPurple),
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      actions: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 20, left: 30),
                                          width: 120,
                                          height: 46,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      AppColors.mLightPurple),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'No'),
                                            child: Text(
                                              'No',
                                              style: AppFonts.medium(
                                                  18, AppColors.mLightPurple),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 20, right: 30),
                                          width: 120,
                                          height: 46,
                                          decoration: BoxDecoration(
                                              color: AppColors.mLightPurple,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'Yes'),
                                            child: Text(
                                              'Yes',
                                              style: AppFonts.medium(
                                                  18, Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                            child: Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black12)),
                              child: Icon(
                                Icons.close,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 250,
                        child: Divider(color: AppColors.mGray),
                      )
                    ]),
                  );
                },
              ),
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    height: 140,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/images/profile.png",
                            ),
                            radius: 45,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hoang Michale",
                                style: AppFonts.medium(18, Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Marketer, Shopee",
                                    style: AppFonts.regular(12, Colors.black),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 70,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: AppColors.mLightPurple,
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all()),
                                    child: Center(
                                      child: Text(
                                        'Mentor',
                                        style:
                                            AppFonts.regular(12, Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "31/10/2022 4:30 PM",
                                    style: AppFonts.regular(12, Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.schedule_outlined,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "60 minutes",
                                    style: AppFonts.regular(12, Colors.black),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Google Meet - ",
                                    style: AppFonts.regular(12, Colors.black),
                                    children: [
                                      TextSpan(
                                        text: 'Ended',
                                        style: AppFonts.medium(
                                            12, AppColors.mDarkPurple),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.black12)),
                              child: Icon(
                                Icons.rate_review_outlined,
                                size: 30,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 250,
                        child: Divider(color: AppColors.mGray),
                      )
                    ]),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
