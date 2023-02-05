import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mentoo/screens/home_page.dart';
import 'package:mentoo/theme/colors.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
        child: BottomNavigationBar(
            backgroundColor: AppColors.mBackground,
            iconSize: 35,
            type: BottomNavigationBarType.fixed,
            onTap: onTap,
            currentIndex: currentIndex,
            selectedItemColor: Colors.black,
            unselectedItemColor: AppColors.mGray,
            //selectedIconTheme: IconThemeData(color: AppColors.mDarkPurple),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 12,
            elevation: 10,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                        color: currentIndex == 0
                            ? AppColors.mLightPurple
                            : AppColors.mBackground,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Icon(
                        Icons.home_outlined,
                      ),
                    ),
                  ),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                        color: currentIndex == 1
                            ? AppColors.mLightPurple
                            : AppColors.mBackground,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Icon(
                        Icons.handshake_outlined,
                      ),
                    ),
                  ),
                  label: "My Course"),
              BottomNavigationBarItem(
                  icon: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                        color: currentIndex == 2
                            ? AppColors.mLightPurple
                            : AppColors.mBackground,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Icon(
                        Icons.person_outline,
                      ),
                    ),
                  ),
                  label: "Transaction"),
              BottomNavigationBarItem(
                  icon: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                        color: currentIndex == 3
                            ? AppColors.mLightPurple
                            : AppColors.mBackground,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Icon(
                        Icons.settings_applications_outlined,
                      ),
                    ),
                  ),
                  label: "My Bookmark"),
            ]),
      ),
    );
  }
}
