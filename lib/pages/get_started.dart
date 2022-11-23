import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.m_background,
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                'assets/images/background.svg',
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SvgPicture.asset(
                'assets/images/four_bubble.svg',
                width: MediaQuery.of(context).size.width / 1.2,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 400,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)
                  ),
                ),
                child: SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 40.0, bottom: 40.0, right: 70.0, left: 70.0),
                        child: Text(
                          'Discover your strengths with your mentor',
                          style: AppFonts.medium(24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 70.0, left: 70.0, bottom: 40.0),
                        child: Text(
                          'Mentoo provides quality mentors to help with your career',
                          style: AppFonts.regular(14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mPrimary,
                            fixedSize: const Size(350, 70),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                          ),
                          onPressed: () => {},
                          child: Text('Get Started',
                              style: AppFonts.medium(25))),
                      const SizedBox(height: 30,),
                      SvgPicture.asset(
                        'assets/images/powered.svg',
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}