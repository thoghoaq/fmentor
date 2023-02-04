import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'dart:convert';

import 'package:mentoo/utils/common.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<Map<String, dynamic>> settings = [
    {
      'title': 'Become a Mentor',
      'backgroundColor': Colors.accents,
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
  List<bool> settingsState = [];

  @override
  void initState() {
    super.initState();
    _fetchSettings();
  }

  _fetchSettings() async {
    // final response = await http
    //     .get(Uri.parse('https://fmentor.azurewebsites.net/userpermissions'));
    // if (response.statusCode == 200) {
    //   setState(() {
    //     settingsState = List<bool>.from(json.decode(response.body));
    //   });
    // } else {
    //   throw Exception('Failed to load settings');
    // }
    setState(() {
      settingsState = [false, true, true, true, true];
    });
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
                child: ListView.builder(
                  itemCount: settingsState.length,
                  itemBuilder: (context, index) {
                    if (settingsState[index]) {
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
