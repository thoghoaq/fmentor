import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/user_permission.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'dart:convert';

import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/loading.dart';

class SettingsPage extends StatefulWidget {
  final int isMentor;

  const SettingsPage({super.key, required this.isMentor});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<Map<String, dynamic>> settings = [
    {
      'title': 'Become a Mentor',
      'backgroundColor': AppColors.mBackground,
      'icon': Icons.person,
      'action': () {}
    },
    {
      'title': 'Settings',
      'backgroundColor': AppColors.mBackground,
      'icon': Icons.settings,
      'action': () {}
    },
    {
      'title': 'Policy',
      'backgroundColor': AppColors.mBackground,
      'icon': Icons.policy,
      'action': () {}
    },
    {
      'title': 'Make your Schedule',
      'backgroundColor': AppColors.mBackground,
      'icon': Icons.calendar_today,
      'action': () {}
    },
    {
      'title': 'Logout',
      'backgroundColor': AppColors.mLightRed,
      'icon': Icons.exit_to_app,
      'action': () {}
    },
  ];
  List<int> settingsState = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchSettings();
  }

  _fetchSettings() async {
    String apiUrl =
        'https://fmentor.azurewebsites.net/api/userpermissions/${widget.isMentor}';
    try {
      final response = await http
          .get(Uri.parse(apiUrl + '?id=' + widget.isMentor.toString()));
      if (response.statusCode == 200) {
        print("API Call: " + apiUrl);
        print("Status: " + response.statusCode.toString());
        print("Body: " + response.body);
        var userPermission =
            UserPermission.fromJson(json.decode(response.body));
        setState(() {
          settingsState = [
            userPermission.canRequestToMentor,
            userPermission.canSeeSettings,
            userPermission.canSeePolicy,

            // userPermission.canFollowMentors,
            userPermission.canMakeSchedule,
            userPermission.canLogout,
            // userPermission.canSeeCourses,
          ];
          // settingsState = [1, 1, 1, 1, 1];
          _loading = false;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            left: AppCommon.screenWidthUnit(context),
            right: AppCommon.screenWidthUnit(context),
            top: AppCommon.screenWidthUnit(context)),
        child: Column(
          children: [
            Container(
              height: AppCommon.screenHeightUnit(context) * 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                  ),
                  SizedBox(height: AppCommon.screenHeightUnit(context) * 0.5),
                  Text(
                    'User Name',
                    style: AppFonts.medium(24, AppColors.mText),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: _loading
                    ? Loading()
                    : ListView.builder(
                        itemCount: settingsState.length,
                        itemBuilder: (context, index) {
                          if (settingsState[index] == 1) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(settings[index]['title']),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: settings[index]['backgroundColor'],
                                    ),
                                    child: Icon(settings[index]['icon'],
                                        size: 30, color: Colors.black),
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Divider()
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
