import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/request/signin_request_model.dart';
import 'package:mentoo/models/view/sign_up_view.dart';
import 'package:mentoo/screens/choose_major.dart';
import 'package:mentoo/screens/home_page.dart';
import 'package:mentoo/screens/sign_in.dart';
import 'package:mentoo/services/user_service.dart';
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
  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";
  var errorName;
  var errorEmail;
  var errorPassword;
  var errorConfirmPassword;
  var errorServer;

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(email);
  }

  bool validatePassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      setState(() {
        errorPassword = 'Password and confirmation do not match';
      });
      return false;
    } else {
      setState(() {
        errorPassword = null;
      });
      return true;
    }
  }

  bool validatePasswordString(String password, bool isPassword) {
    if (password.length < 3 || password.length > 8) {
      if (isPassword)
        setState(() {
          errorPassword = 'Password must be between 8 and 16 characters';
        });
      else
        setState(() {
          errorConfirmPassword =
              'Confirm Password must be between 8 and 16 characters';
        });
      return false;
    } else {
      if (isPassword)
        setState(() {
          errorPassword = null;
        });
      else
        setState(() {
          errorConfirmPassword = null;
        });
      return true;
    }
  }

  bool validateName(String name) {
    if (name.trim().length < 3) {
      setState(() {
        errorName = 'Name must be more than 3 characters';
      });
      return false;
    } else {
      setState(() {
        errorName = null;
      });
      return true;
    }
  }

  bool validateEmail(String email) {
    if (!isValidEmail(email)) {
      setState(() {
        errorEmail = 'Invalid email address';
      });
      return false;
    } else {
      setState(() {
        errorEmail = null;
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double whiteSpace = AppCommon.screenHeight(context) * 0.1;
    return Scaffold(
      body: ListView(children: [
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
            errorServer != null
                ? Text(
                    errorServer,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 288,
                height: errorName != null ? 64 : 44,
                child: TextField(
                  onChanged: (value) => name = value,
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorColor: AppColors.mDarkPurple,
                  decoration: InputDecoration(
                    errorText: errorName,
                    hintStyle: TextStyle(color: AppColors.mGray),
                    hintText: 'Name',
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
                      child: Icon(Icons.person_outline, color: AppColors.mGray),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 288,
                height: errorEmail != null ? 64 : 44,
                child: TextField(
                  onChanged: (value) => email = value,
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorColor: AppColors.mDarkPurple,
                  decoration: InputDecoration(
                    errorText: errorEmail,
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
                height: errorPassword != null ? 64 : 44,
                child: TextField(
                  onChanged: (value) => password = value,
                  obscureText: passEnable,
                  cursorColor: AppColors.mDarkPurple,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    errorText: errorPassword,
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
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 288,
                height: errorConfirmPassword != null ? 64 : 44,
                child: TextField(
                  onChanged: (value) => confirmPassword = value,
                  obscureText: passEnable,
                  cursorColor: AppColors.mDarkPurple,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                    errorText: errorConfirmPassword,
                    hintStyle: TextStyle(color: AppColors.mGray),
                    hintText: 'Confirm password',
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
                      )), () async {
                if (validateEmail(email) &&
                    validateName(name) &&
                    validatePasswordString(password, true) &&
                    validatePasswordString(confirmPassword, false) &&
                    validatePassword(password, confirmPassword)) {
                  print("validate");
                  SignUpModel signUp = SignUpModel(
                      name: name.trim(),
                      email: email.trim(),
                      password: password.trim(),
                      confirmPassword: confirmPassword.trim());

                  try {
                    var user = await UserService().signUp(signUp);
                    if (user != null) {
                      SignInRequestModel model = SignInRequestModel(
                          email: user.email, password: user.password);
                      await UserService().signIn(model);
                      Get.to(ChooseMajor(
                        userId: user!.userId,
                      ));
                    }
                  } catch (e) {
                    setState(() {
                      errorServer = e.toString();
                    });
                  }
                }
              }),
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
