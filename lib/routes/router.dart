import 'package:flutter/material.dart';
import 'package:mentoo/screens/choose_major.dart';
import 'package:mentoo/screens/get_started.dart';
import 'package:mentoo/screens/sign_in.dart';
import 'package:mentoo/screens/sign_up.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'GetStarted':
        {
          return MaterialPageRoute(builder: (_) => const GetStarted());
        }
      case 'SignIn':
        {
          return MaterialPageRoute(builder: (_) => const SignIn());
        }
      case 'SignUp':
        {
          return MaterialPageRoute(builder: (_) => const SignUp());
        }
      case 'ChooseMajor':
        {
          return MaterialPageRoute(builder: (_) => const ChooseMajor());
        }
      default:
        {
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                    body: Center(
                        child: Text('No route defined for ${settings.name}')),
                  ));
        }
    }
  }
}
