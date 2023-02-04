import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

import '../utils/common.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    var searchAreaContainerWidth = AppCommon.screenWidthUnit(context) * 11;
    var searchAreaContainerHeight = AppCommon.screenHeightUnit(context) * 3;
    return Scaffold(
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
            'Notification',
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(AppCommon.screenHeightUnit(context) * 0.2),
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 19,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: Image.asset(
                        "assets/images/home_page.png",
                        width: searchAreaContainerWidth * 0.16,
                        height: searchAreaContainerHeight * 0.4,
                      ),
                      title: Text(
                        'Two-line ListTile anh vui ve anh vui ve Two-line ListTile Two-line ListTile anh vui ve anh vui ve Two-line ListTile Two-line ListTile anh vui ve anh vui ve Two-line ListTile',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: TextStyle(fontSize: 12),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            size: 16,
                            color: AppColors.mDarkPurple,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '22 hours ago',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      //trailing: Text("Wed 12 Dec"),
                    ),
                  );
                })));
  }
}
