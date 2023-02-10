import 'package:flutter/material.dart';
import 'package:mentoo/screens/home_page.dart';
import 'package:mentoo/screens/my_mentees.dart';
import 'package:mentoo/screens/profile.dart';
import 'package:mentoo/screens/settings_page.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';

import 'my_appointments.dart';

class MainPage extends StatefulWidget {
  final int? userId;
  final int isMentor;
  final int? mentorId;
  final int? menteeId;
  final int initialPage;
  const MainPage(
      {Key? key,
      required this.isMentor,
      required this.initialPage,
      this.userId,
      this.mentorId,
      this.menteeId})
      : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Map<String, Object>> pageItems = [
    {
      'title': 'Home',
      'icon': Icons.home_outlined,
      'state': true,
    },
    {
      'title': 'Mentor',
      'icon': Icons.handshake_outlined,
      'state': true,
    },
    {
      'title': 'Profile',
      'icon': Icons.person,
      'state': true,
    },
    {
      'title': 'Mentee',
      'icon': Icons.waving_hand_outlined,
      'state': false,
    },
    {
      'title': 'Setting',
      'icon': Icons.settings_outlined,
      'state': true,
    },
  ];
  late int _selectedPageIndex;
  List pages = [];

  void _selectPage(int index) async {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _settingPage(widget.isMentor);
    _selectedPageIndex = widget.initialPage;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _settingPage(int isMentor) {
    if (isMentor == 1) {
      pageItems[3]['state'] = true;
      pages = [
        const HomePage(),
        MyAppointments(
          userId: int.parse(widget.userId.toString()),
        ),
        Profile(userId: widget.userId),
        MyMentees(
          mentorId: widget.mentorId,
          userId: int.parse(widget.userId.toString()),
        ),
        SettingsPage(
          isMentor: isMentor,
        )
      ];
    } else {
      pages = [
        const HomePage(),
        MyAppointments(
          userId: int.parse(widget.userId.toString()),
        ),
        Profile(userId: widget.userId),
        SettingsPage(
          isMentor: isMentor,
        )
      ];
      pageItems = [
        {
          'title': 'Home',
          'icon': Icons.home_outlined,
          'state': true,
        },
        {
          'title': 'Mentor',
          'icon': Icons.handshake_outlined,
          'state': true,
        },
        {
          'title': 'Profile',
          'icon': Icons.person,
          'state': true,
        },
        {
          'title': 'Setting',
          'icon': Icons.settings_outlined,
          'state': true,
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_selectedPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.mNavigationBar,
          onTap: _selectPage,
          showSelectedLabels: false,
          selectedIconTheme: const IconThemeData(size: 30),
          items: pageItems
              .where((element) => element['state'] == true)
              .map(
                (page) => BottomNavigationBarItem(
                  icon: Container(
                    height: 41,
                    width: 46,
                    decoration: _selectedPageIndex == pageItems.indexOf(page)
                        ? const BoxDecoration(
                            color: AppColors.mBackground,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(15)))
                        : null,
                    child: Icon(page['icon'] as IconData,
                        color: AppColors.mGrayStroke),
                  ),
                  label: page['title'].toString(),
                ),
              )
              .toList(),
          currentIndex: _selectedPageIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ));
  }
}
