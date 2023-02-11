import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/request/signin_request_model.dart';
import 'package:mentoo/screens/main_home_page.dart';
import 'package:mentoo/screens/sign_up.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/theme/components.dart';
import 'package:mentoo/utils/common.dart';
import 'package:mentoo/widgets/alert_dialog.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  SignInRequestModel _signinModel =
      SignInRequestModel(email: "", password: "");
  bool passEnable = true;
  bool _isSigning = false;
  bool? _singinSuccess;

  @override
  Widget build(BuildContext context) {
    double whiteSpace = AppCommon.screenHeight(context) * 0.1;
    return Scaffold(
      body: _isSigning
          ? AlertPopup(
              icon: Image.asset("assets/images/logo.png"),
              title: "Signing",
              message: "Wait for a minutes",
            )
          : _singinSuccess == false
              ? AlertPopup(
                  icon: Image.asset("assets/images/logo.png"),
                  title: "Opps, Failed",
                  message: "Something when wrong !",
                  buttons: [
                    TextButton(
                      onPressed: () => setState(() {
                        _singinSuccess = null;
                      }),
                      child: Text(
                        'Try again',
                        style: AppFonts.medium(18, Colors.white),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(top: whiteSpace),
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 100,
                          height: AppCommon.screenHeight(context) * 0.1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: Text('FMentor',
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
                                style:
                                    AppFonts.bold(14, AppColors.mDarkPurple)),
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
                                style:
                                    AppFonts.bold(14, AppColors.mDarkPurple)),
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
                                style:
                                    AppFonts.bold(14, AppColors.mDarkPurple)),
                            () => {}),
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
                            onSubmitted: (value) =>
                                {_signinModel.email = value},
                            onChanged: (value) => _signinModel.email = value,
                            textAlignVertical: TextAlignVertical.bottom,
                            cursorColor: AppColors.mDarkPurple,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: AppColors.mGray),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: sqrt1_2)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                borderSide:
                                    BorderSide(color: AppColors.mDarkPurple),
                              ),
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 10.0),
                                child: Icon(Icons.email_outlined,
                                    color: AppColors.mGray),
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
                            onSubmitted: (value) =>
                                {_signinModel.password = value},
                            onChanged: (value) => _signinModel.password = value,
                            obscureText: passEnable,
                            cursorColor: AppColors.mDarkPurple,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: AppColors.mGray),
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: sqrt1_2)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                borderSide:
                                    BorderSide(color: AppColors.mDarkPurple),
                              ),
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: 20.0, right: 10.0),
                                child: Icon(Icons.lock_outline,
                                    color: AppColors.mGray),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, right: 50.0),
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
                        // child: AppComponents.generalButton(
                        //     Text('Sign in',
                        //         style: AppFonts.medium(
                        //           16,
                        //           Colors.white,
                        //         )),
                        //     context),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mLightPurple,
                            fixedSize: const Size(288, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isSigning = true;
                            });
                            var user = await UserService().signIn(_signinModel);
                            if (user != null) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage(
                                          initialPage: 0,
                                          isMentor: user.isMentor,
                                          userId: user.userId,
                                        )),
                              );
                            } else {
                              setState(() {
                                _isSigning = false;
                                _singinSuccess = false;
                              });
                            }
                          },
                          child: Text('Sign in',
                              style: AppFonts.medium(
                                16,
                                Colors.white,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an account? ',
                              style:
                                  AppFonts.regular(14, AppColors.mDarkPurple),
                            ),
                            GestureDetector(
                              child: Text(
                                'Sign up',
                                style: AppFonts.bold(14, AppColors.mDarkPurple),
                              ),
                              onTap: () => {Get.to(const SignUp())},
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
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
