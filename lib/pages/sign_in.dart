import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/theme/components.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  bool passEnable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        height: 1000,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Image.asset(
              'assets/images/logo.png',
              width: 100,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: Text('Mentoo',
                style: AppFonts.bold(
                  50,
                  AppColors.mDarkPurple,
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppComponents.socialButton(
                Image.asset(
                  'assets/images/facebook.png',
                  width: 18,
                ),
                Text('Sign in with Facebook',
                    style: AppFonts.bold(14, AppColors.mDarkPurple))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppComponents.socialButton(
                Image.asset(
                  'assets/images/google.png',
                  width: 18,
                ),
                Text('Sign in with Google',
                    style: AppFonts.bold(14, AppColors.mDarkPurple))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppComponents.socialButton(
                Image.asset(
                  'assets/images/apple.png',
                  width: 18,
                ),
                Text('Sign in with Apple',
                    style: AppFonts.bold(14, AppColors.mDarkPurple))),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: BreakLine(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 288,
              height: 44,
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                cursorColor: AppColors.mDarkPurple,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: AppColors.mGray),
                  hintText: 'Email',
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      borderSide:
                          BorderSide(color: Colors.black, width: sqrt1_2)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(100.0)),
                    borderSide: BorderSide(color: AppColors.mDarkPurple),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Icon(Icons.email_outlined, color: AppColors.mGray),
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
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: AppColors.mGray),
                  hintText: 'Password',
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                      borderSide:
                          BorderSide(color: Colors.black, width: sqrt1_2)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(100.0)),
                    borderSide: BorderSide(color: AppColors.mDarkPurple),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Icon(Icons.lock_outline, color: AppColors.mGray),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 50.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                child: Text(
                  'Forget password?',
                  style: AppFonts.bold(14, AppColors.mDarkPurple),
                ),
                onTap: () => {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppComponents.generalButton(Text('Sign in',
                style: AppFonts.medium(
                  16,
                  Colors.white,
                ))),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don’t have an account? ',
                  style: AppFonts.regular(14, AppColors.mDarkPurple),
                ),
                GestureDetector(
                  child: Text(
                    'Sign up',
                    style: AppFonts.bold(14, AppColors.mDarkPurple),
                  ),
                  onTap: () => {},
                )
              ],
            ),
          )
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
    return Stack(
      children: const [
        Divider(
          color: Colors.black,
          indent: 50,
          endIndent: 220,
        ),
        Center(child: Text('Or')),
        Divider(
          color: Colors.black,
          indent: 220,
          endIndent: 50,
        ),
      ],
    );
  }
}
