import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/user.dart';
import 'package:mentoo/models/user_permission.dart' as permission;
import 'package:mentoo/screens/make_your_schedule.dart';
import 'package:mentoo/screens/sign_in.dart';
import 'package:mentoo/screens/your_courses.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/services/wallet_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'dart:convert';

import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final int isMentor;

  const SettingsPage({
    super.key,
    required this.isMentor,
  });
  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<Map<String, dynamic>> settings = [
    {
      'title': 'Become a Mentor',
      'backgroundColor': AppColors.mBackground,
      'icon': Icons.person,
      'action': (context) {}
    },
    {
      'title': 'Settings',
      'backgroundColor': AppColors.mBackground,
      'icon': Icons.settings,
      'action': (context) {}
    },
    {
      'title': 'Policy',
      'backgroundColor': AppColors.mBackground,
      'icon': Icons.policy,
      'action': (context) {}
    },
    {
      'title': 'Make your Schedule',
      'backgroundColor': AppColors.mBackground,
      'icon': Icons.calendar_today,
      'action': (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SchedulePage()),
        );
      }
    },
    {
      'title': 'My Courses',
      'backgroundColor': AppColors.mBackground,
      'icon': Icons.book,
      'action': (context) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const YourCourses()),
        );
      }
    },
    {
      'title': 'Logout',
      'backgroundColor': AppColors.mLightRed,
      'icon': Icons.exit_to_app,
      'action': (context) async {
        await UserService().clearSharedPreferences();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
        );
      }
    },
  ];
  List<int> settingsState = [];
  bool _loading = true;
  String? _userName;
  String? _userPhoto;
  User? _user;
  Wallet? _wallets;

  @override
  void initState() {
    _fetchSettings();
    super.initState();
  }

// To save the list
  Future<void> saveSettingsState(List<int> settingsState) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('settingsState', jsonEncode(settingsState));
  }

// To retrieve the list
  Future<List<int>> getSettingsState() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsStateString = prefs.getString('settingsState');
    if (settingsStateString != null) {
      return jsonDecode(settingsStateString).cast<int>();
    }
    return [];
  }

  _fetchSettings() async {
    _user = await UserService().getUser();
    _wallets =
        await WalletService().getWalletById(_user!.wallets!.first.walletId);
    _userName = _user!.name;
    _userPhoto = _user!.photo;
    //get setting list from sharedreferences
    var settingsStateString = await getSettingsState();
    if (settingsStateString.isNotEmpty) {
      String apiUrl =
          'https://fmentor.azurewebsites.net/api/userpermissions/${widget.isMentor}';
      try {
        final response =
            await http.get(Uri.parse('$apiUrl?id=${widget.isMentor}'));
        if (response.statusCode == 200) {
          if (kDebugMode) {
            print("Status: ${response.statusCode}");
            print("Body: ${response.body}");
            print("API Call: $apiUrl");
          }
          var userPermission =
              permission.UserPermission.fromJson(json.decode(response.body));
          if (!mounted) return;
          setState(() {
            settingsState = [
              userPermission.canRequestToMentor,
              userPermission.canSeeSettings,
              userPermission.canSeePolicy,

              // userPermission.canFollowMentors,
              userPermission.canMakeSchedule,
              userPermission.canSeeCourses,
              userPermission.canLogout,
            ];
            // settingsState = [1, 1, 1, 1, 1];
            _loading = false;
          });
          saveSettingsState(settingsState);
        } else {
          if (kDebugMode) {
            print('Request failed with status: ${response.statusCode}');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } else {
      setState(() {
        settingsState = settingsStateString;
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: EdgeInsets.only(
                  left: AppCommon.screenWidthUnit(context),
                  right: AppCommon.screenWidthUnit(context),
                  top: AppCommon.screenWidthUnit(context)),
              child: Column(
                children: [
                  SizedBox(
                    height: AppCommon.screenHeightUnit(context) * 3.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: _userPhoto != null
                              ? NetworkImage(_userPhoto.toString())
                              : null,
                          radius: 50,
                        ),
                        SizedBox(
                            height: AppCommon.screenHeightUnit(context) * 0.5),
                        Text(
                          _userName.toString(),
                          style: AppFonts.medium(24, AppColors.mText),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            width: 160,
                            height: 35,
                            decoration: const BoxDecoration(
                                color: AppColors.mLightRed,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Center(
                                child: Text("Balance: ${_wallets!.balance}")),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: _loading
                          ? const Loading()
                          : ListView.builder(
                              itemCount: settingsState.length,
                              itemBuilder: (context, index) {
                                if (settingsState[index] == 1) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            settings[index]['action'](context),
                                        child: ListTile(
                                          title: Text(settings[index]['title']),
                                          leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              color: settings[index]
                                                  ['backgroundColor'],
                                            ),
                                            alignment: Alignment.center,
                                            child: Icon(settings[index]['icon'],
                                                size: 30, color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const Divider()
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
