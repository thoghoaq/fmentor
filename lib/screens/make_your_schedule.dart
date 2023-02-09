import 'package:flutter/material.dart';
import 'package:mentoo/screens/settings_page.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/button.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  final _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final _selectedDays = <String>[];

  TimeOfDay _fromTime = TimeOfDay.now();
  TimeOfDay _toTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        title: Text(
          "Make your schedule",
          style: AppFonts.medium(24, AppColors.mDarkPurple),
        ),
        leading: BackButton(
          color: AppColors.mDarkPurple,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: AppCommon.screenWidthUnit(context),
          right: AppCommon.screenWidthUnit(context),
        ),
        child: Stack(children: [
          Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.view_week_outlined,
                  color: AppColors.mDarkPurple,
                ),
                title: Text('Working days',
                    style: AppFonts.medium(16, AppColors.mDarkPurple)),
              ),
              SizedBox(
                height: AppCommon.screenHeightUnit(context) * 3,
                child: GridView.count(
                  childAspectRatio: (50 / 20),
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: [
                    OutlinedButton(
                      child: Text(
                        'Monday',
                        style: TextStyle(
                            color: _selectedDays.contains('Monday')
                                ? Colors.white
                                : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_selectedDays.contains('Monday')) {
                            _selectedDays.remove('Monday');
                          } else {
                            _selectedDays.add('Monday');
                          }
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fixedSize: Size(10, 10),
                          foregroundColor: _selectedDays.contains('Monday')
                              ? AppColors.mLightPurple
                              : Colors.grey[300],
                          backgroundColor: _selectedDays.contains('Monday')
                              ? AppColors.mPrimary
                              : Colors.white,
                          side: BorderSide(
                              color: AppColors.mPrimary, width: 1.5)),
                    ),
                    OutlinedButton(
                      child: Text(
                        'Tuesday',
                        style: TextStyle(
                            color: _selectedDays.contains('Tuesday')
                                ? Colors.white
                                : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_selectedDays.contains('Tuesday')) {
                            _selectedDays.remove('Tuesday');
                          } else {
                            _selectedDays.add('Tuesday');
                          }
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fixedSize: Size(10, 10),
                          foregroundColor: _selectedDays.contains('Tuesday')
                              ? AppColors.mLightPurple
                              : Colors.white,
                          backgroundColor: _selectedDays.contains('Tuesday')
                              ? AppColors.mPrimary
                              : Colors.white,
                          side: BorderSide(
                              color: AppColors.mPrimary, width: 1.5)),
                    ),
                    OutlinedButton(
                      child: Text(
                        'Wednesday',
                        style: TextStyle(
                            color: _selectedDays.contains('Wednesday')
                                ? Colors.white
                                : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_selectedDays.contains('Wednesday')) {
                            _selectedDays.remove('Wednesday');
                          } else {
                            _selectedDays.add('Wednesday');
                          }
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fixedSize: Size(10, 10),
                          foregroundColor: _selectedDays.contains('Wednesday')
                              ? AppColors.mLightPurple
                              : Colors.grey[300],
                          backgroundColor: _selectedDays.contains('Wednesday')
                              ? AppColors.mPrimary
                              : Colors.white,
                          side: BorderSide(
                              color: AppColors.mPrimary, width: 1.5)),
                    ),
                    OutlinedButton(
                      child: Text(
                        'Thurday',
                        style: TextStyle(
                            color: _selectedDays.contains('Thurday')
                                ? Colors.white
                                : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_selectedDays.contains('Thurday')) {
                            _selectedDays.remove('Thurday');
                          } else {
                            _selectedDays.add('Thurday');
                          }
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fixedSize: Size(10, 10),
                          foregroundColor: _selectedDays.contains('Thurday')
                              ? AppColors.mLightPurple
                              : Colors.grey[300],
                          backgroundColor: _selectedDays.contains('Thurday')
                              ? AppColors.mPrimary
                              : Colors.white,
                          side: BorderSide(
                              color: AppColors.mPrimary, width: 1.5)),
                    ),
                    OutlinedButton(
                      child: Text(
                        'Friday',
                        style: TextStyle(
                            color: _selectedDays.contains('Friday')
                                ? Colors.white
                                : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_selectedDays.contains('Friday')) {
                            _selectedDays.remove('Friday');
                          } else {
                            _selectedDays.add('Friday');
                          }
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fixedSize: Size(10, 10),
                          foregroundColor: _selectedDays.contains('Friday')
                              ? AppColors.mLightPurple
                              : Colors.grey[300],
                          backgroundColor: _selectedDays.contains('Friday')
                              ? AppColors.mPrimary
                              : Colors.white,
                          side: BorderSide(
                              color: AppColors.mPrimary, width: 1.5)),
                    ),
                    OutlinedButton(
                      child: Text(
                        'Saturday',
                        style: TextStyle(
                            color: _selectedDays.contains('Saturday')
                                ? Colors.white
                                : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_selectedDays.contains('Saturday')) {
                            _selectedDays.remove('Saturday');
                          } else {
                            _selectedDays.add('Saturday');
                          }
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fixedSize: Size(10, 10),
                          foregroundColor: _selectedDays.contains('Saturday')
                              ? AppColors.mLightPurple
                              : Colors.grey[300],
                          backgroundColor: _selectedDays.contains('Saturday')
                              ? AppColors.mPrimary
                              : Colors.white,
                          side: BorderSide(
                              color: AppColors.mPrimary, width: 1.5)),
                    ),
                    OutlinedButton(
                      child: Text(
                        'Sunday',
                        style: TextStyle(
                            color: _selectedDays.contains('Sunday')
                                ? Colors.white
                                : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_selectedDays.contains('Sunday')) {
                            _selectedDays.remove('Sunday');
                          } else {
                            _selectedDays.add('Sunday');
                          }
                        });
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fixedSize: Size(10, 10),
                          foregroundColor: _selectedDays.contains('Sunday')
                              ? AppColors.mLightPurple
                              : Colors.grey[300],
                          backgroundColor: _selectedDays.contains('Sunday')
                              ? AppColors.mPrimary
                              : Colors.white,
                          side: BorderSide(
                              color: AppColors.mPrimary, width: 1.5)),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.view_timeline_outlined,
                  color: AppColors.mDarkPurple,
                ),
                title: Text('Working time',
                    style: AppFonts.medium(16, AppColors.mDarkPurple)),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text('From',
                        style: AppFonts.medium(16, AppColors.mDarkPurple)),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: _fromTime,
                        );
                        if (selectedTime != null) {
                          setState(() {
                            _fromTime = selectedTime;
                          });
                        }
                      },
                      child: Container(
                        child: Text('${_fromTime.format(context)}'),
                      ),
                      style: OutlinedButton.styleFrom(
                          fixedSize: Size(50, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          foregroundColor: Colors.black,
                          side: BorderSide(
                              color: AppColors.mPrimary, width: 1.5)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text('To',
                        style: AppFonts.medium(16, AppColors.mDarkPurple)),
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: _toTime,
                        );
                        if (selectedTime != null) {
                          setState(() {
                            _toTime = selectedTime;
                          });
                        }
                      },
                      child: Container(
                        child: Text('${_toTime.format(context)}'),
                      ),
                      style: OutlinedButton.styleFrom(
                          fixedSize: Size(50, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          foregroundColor: Colors.black,
                          side: BorderSide(
                              color: AppColors.mPrimary, width: 1.5)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: AppCommon.screenWidthUnit(context)),
              child: PrimaryButton(),
            ),
          ),
        ]),
      ),
    );
  }
}
