import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/screens/sign_in.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/theme/components.dart';
import 'package:mentoo/utils/common.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  bool passEnable = true;
  @override
  Widget build(BuildContext context) {
    double whiteSpace = AppCommon.screenHeight(context) * 0.1;
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        height: 1000,
        child: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30.0),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(top: whiteSpace),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: Text('Mentoo',
                      style: AppFonts.bold(
                        50,
                        AppColors.mDarkPurple,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppComponents.socialButton(
                    Image.asset(
                      'assets/images/facebook.png',
                      width: 18,
                    ),
                    Text('Sign in with Facebook',
                        style: AppFonts.bold(14, AppColors.mDarkPurple)),
                    () => {}),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppComponents.socialButton(
                    Image.asset(
                      'assets/images/google.png',
                      width: 18,
                    ),
                    Text('Sign in with Google',
                        style: AppFonts.bold(14, AppColors.mDarkPurple)),
                    () => {}),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppComponents.socialButton(
                    Image.asset(
                      'assets/images/apple.png',
                      width: 18,
                    ),
                    Text('Sign in with Apple',
                        style: AppFonts.bold(14, AppColors.mDarkPurple)),
                    () => {}),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: BreakLine(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 288,
                  height: 44,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    cursorColor: AppColors.mDarkPurple,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.mGray),
                      hintText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: sqrt1_2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        borderSide: BorderSide(color: AppColors.mDarkPurple),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 10.0),
                        child:
                            Icon(Icons.person_outline, color: AppColors.mGray),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 288,
                  height: 44,
                  child: TextField(
                    textAlignVertical: TextAlignVertical.bottom,
                    cursorColor: AppColors.mDarkPurple,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: AppColors.mGray),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: sqrt1_2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        borderSide: BorderSide(color: AppColors.mDarkPurple),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 10.0),
                        child:
                            Icon(Icons.email_outlined, color: AppColors.mGray),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 288,
                  height: 44,
                  child: TextField(
                    obscureText: passEnable,
                    cursorColor: AppColors.mDarkPurple,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: AppColors.mGray),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: sqrt1_2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        borderSide: BorderSide(color: AppColors.mDarkPurple),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Icon(Icons.lock_outline, color: AppColors.mGray),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 288,
                  height: 44,
                  child: TextField(
                    obscureText: passEnable,
                    cursorColor: AppColors.mDarkPurple,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: AppColors.mGray),
                      hintText: 'Confirm password',
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100.0)),
                          borderSide:
                              BorderSide(color: Colors.black, width: sqrt1_2)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        borderSide: BorderSide(color: AppColors.mDarkPurple),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Icon(Icons.lock_outline, color: AppColors.mGray),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 288,
                    child: GestureDetector(
                      child: Text(
                        'By press on Sign up, you will agree with our Terms of Services & Privacy Policy',
                        style: AppFonts.bold(14, AppColors.mDarkPurple),
                      ),
                      onTap: () => {},
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppComponents.generalButton(
                    Text('Sign up',
                        style: AppFonts.medium(
                          16,
                          Colors.white,
                        )),
                    () => {Get.to(const SignUp())}),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an account? ',
                      style: AppFonts.regular(14, AppColors.mDarkPurple),
                    ),
                    GestureDetector(
                      child: Text(
                        'Sign in',
                        style: AppFonts.bold(14, AppColors.mDarkPurple),
                      ),
                      onTap: () => {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => const SignIn()))
                      },
                    )
                  ],
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

//Break line
class BreakLine extends StatelessWidget {
  const BreakLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.black,
      indent: 60,
      endIndent: 60,
    );
  }
}
