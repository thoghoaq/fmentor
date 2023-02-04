import 'package:flutter/material.dart';
import 'package:mentoo/screens/home_page.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

class FollowMentor extends StatefulWidget {
  const FollowMentor({super.key});

  @override
  State<FollowMentor> createState() => _FollowMentorState();
}

class _FollowMentorState extends State<FollowMentor> {
  List<String> _specialties = [];
  String _selectedSpecialty = "Graphic Design";

  @override
  void initState() {
    super.initState();
    _fetchSpecialties();
  }

  void _fetchSpecialties() async {
    setState(() {
      _specialties = [
        "Graphic Design",
        "Marketing",
        "Software Engineering",
        "Others"
      ];
    });
  }

  void _showSpecialtiesMenu(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.topRight,
          child: Container(
            height: _specialties.length * 50,
            width: 1000,
            decoration: BoxDecoration(
                color: AppColors.m_background,
                borderRadius: BorderRadius.circular(10)),
            child: ListView.builder(
              itemCount: _specialties.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print(index);
                    setState(() {
                      _selectedSpecialty = _specialties[index];
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    color: _selectedSpecialty == _specialties[index]
                        ? AppColors.mLightPurple
                        : AppColors.m_background,
                    child: Text(
                      _specialties[index],
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          InkWell(
              onTap: () {
                _showSpecialtiesMenu(context);
              },
              child: Icon(Icons.filter_alt_outlined,
                  color: Colors.black, size: 30)),
          SizedBox(
            width: 10,
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: AppFonts.medium(30, AppColors.mDarkPurple),
        title: const Text(
          'Followed Mentors',
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: GridView.count(
            //physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            primary: false,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            children: List.generate(
              10,
              (index) => const ProfileCard(),
            )),
      ),
    );
  }
}
