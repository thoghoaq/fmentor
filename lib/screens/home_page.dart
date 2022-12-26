import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 1770,
          padding: EdgeInsets.only(right: 25, left: 25, top: 20),
          child: SafeArea(
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Hi ',
                      style: AppFonts.regular(25, Colors.black),
                      children: [
                        TextSpan(
                            text: 'Edward ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        WidgetSpan(
                          child: Icon(
                            Icons.hive_outlined,
                            size: 35,
                            color: Colors.yellow,
                          ),
                        ),
                        TextSpan(text: '\nFind your great mentor!'),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.notifications_none_outlined,
                    size: 35,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 235,
                width: 500,
                decoration: BoxDecoration(
                    color: AppColors.mLightPurple,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(children: [
                    TextFormField(
                      initialValue: "Search for mentor",
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.mDarkPurple,
                        ),
                        contentPadding: const EdgeInsets.only(left: 10),
                        filled: true,
                        fillColor: Colors.white,
                        // focusColor: AppColors.grayColor,
                        // hoverColor: AppColors.grayColor,
                        //labelText: "Search for mentor ",
                        labelStyle: AppFonts.medium(16, AppColors.mText),
                        //errorText: 'Error message',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 190,
                          child: RichText(
                            maxLines: 3,
                            text: TextSpan(
                              text: 'Get connect with ',
                              style: TextStyle(fontSize: 16),
                              children: [
                                TextSpan(
                                    text: '300+',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text:
                                        ' best Mentor and get solutions for your career'),
                              ],
                            ),
                          ),
                        ),
                        Image.asset(
                          "assets/images/home_page.png",
                          width: 145,
                        )
                      ],
                    )
                  ]),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Top Contributors",
                    style: AppFonts.medium(18, Colors.black),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Show More ",
                      style: AppFonts.regular(16, AppColors.mDarkPurple),
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: AppColors.mDarkPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    primary: false,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    children: List.generate(
                      10,
                      (index) => Card(
                        //elevation: 5,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          //set border radius more than 50% of height and width to make circle
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/profile.png"),
                                  fit: BoxFit.cover)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lauria Warner',
                                  style: AppFonts.medium(16, Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    'UI/UX Designer,\nUnicloudCA',
                                    style: AppFonts.regular(10, Colors.black),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: AppColors.mLightPurple,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all()),
                                  child: Center(
                                    child: Text(
                                      'Mentor',
                                      style: AppFonts.medium(16, Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
