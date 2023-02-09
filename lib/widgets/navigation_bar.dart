import 'package:flutter/material.dart';
import 'package:mentoo/screens/home_page.dart';
import 'package:mentoo/screens/my_appointments.dart';
import 'package:mentoo/screens/profile.dart';
import 'package:mentoo/screens/settings_page.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int isMentor;
  final int initialPage;

  MyBottomNavigationBar({
    required this.isMentor,
    this.initialPage = 0,
  });

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  final List<Map<String, Object>> pages = [
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
  late int _userId = -1;

  @override
  void initState() {
    _settingPage(widget.isMentor);
    _selectedPageIndex = widget.initialPage;
    _getUser();
    super.initState();
  }

  _getUser() async {
    var user = await UserService().getUser();
    if (user != null) {
      _userId = user.userId;
    }
  }

  void _selectPage(int index) async {
    setState(() {
      _selectedPageIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyAppointments(
                      menteeId: 1,
                    )));
        break;
      case 2:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Profile(userId: _userId)));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyAppointments(
                      menteeId: 1,
                    )));
        break;
      case 4:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SettingsPage(
                      isMentor: 1,
                    )));
        break;
    }
  }

  void _settingPage(int isMentor) {
    if (isMentor == 1) {
      setState(() {
        pages[3]['state'] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.mNavigationBar,
      onTap: _selectPage,
      showSelectedLabels: false,
      selectedIconTheme: IconThemeData(size: 30),
      items: pages
          .where((element) => element['state'] == true)
          .map(
            (page) => BottomNavigationBarItem(
              icon: Container(
                height: 41,
                width: 46,
                decoration: _selectedPageIndex == pages.indexOf(page)
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
    );
  }
}
