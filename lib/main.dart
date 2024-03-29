// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:mentoo/models/course.dart';
import 'package:mentoo/models/mentor.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/screens/book_appointment.dart';
import 'package:mentoo/screens/choose_major.dart';
import 'package:mentoo/screens/edit_education.dart';
import 'package:mentoo/screens/edit_job.dart';
import 'package:mentoo/screens/edit_profile.dart';
import 'package:mentoo/screens/favorite_courses.dart';
import 'package:mentoo/screens/follow_mentors.dart';
import 'package:mentoo/screens/get_started.dart';
import 'package:mentoo/screens/home_page.dart';

import 'package:mentoo/screens/main_home_page.dart';
import 'package:mentoo/screens/meeting_end.dart';
import 'package:mentoo/screens/mentor_detail.dart';
import 'package:mentoo/screens/mentor_meeting_end.dart';
import 'package:mentoo/screens/mentor_recommend_courses.dart';
import 'package:mentoo/screens/my_appointments.dart';
import 'package:mentoo/screens/notification.dart';
import 'package:mentoo/screens/profile.dart';
import 'package:mentoo/screens/recommend_courses.dart';

import 'package:mentoo/screens/make_your_schedule.dart';
import 'package:mentoo/screens/settings_page.dart';

import 'package:mentoo/screens/search.dart';
import 'package:mentoo/screens/sign_in.dart';
import 'package:mentoo/screens/sign_up.dart';
import 'package:mentoo/screens/specialist_mentors.dart';
import 'package:mentoo/screens/top_mentor.dart';
import 'package:mentoo/screens/write_review.dart';
import 'package:mentoo/services/course_service.dart';
import 'package:mentoo/services/local_notification_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/widgets/loading.dart';

// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => const MyApp(), // Wrap your app
//       ),
//     );
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _loading = true;
  bool _isFirstLogin = true;
  User? _user;
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    _checkUserExist();
    LocalNotificationService().initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        if (routeFromMessage == "mentee")
          Get.to(MeetingEnd());
        else if (routeFromMessage!.substring(0, 11) == "recommended") {
          var subString = routeFromMessage.substring(14);
          var courses = await CourseService().getCoursesRecommended(subString);
          Get.to(RecommendCourses(
            courses: courses,
          ));
        } else
          Get.to(MentorMeetingEnded(
            token: routeFromMessage!,
          ));
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalNotificationService().display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      final routeFromMessage = message.data["route"];
      if (routeFromMessage == "mentee")
        Get.to(MeetingEnd());
      else if (routeFromMessage!.substring(0, 11) == "recommended") {
        var subString = routeFromMessage.substring(14);
        var courses = await CourseService().getCoursesRecommended(subString);
        Get.to(RecommendCourses(
          courses: courses,
        ));
      } else
        Get.to(MentorMeetingEnded(
          token: routeFromMessage!,
        ));
    });
  }

  _checkUserExist() async {
    var user = await UserService().getUser();
    if (user != null) {
      setState(() {
        _isFirstLogin = false;
        _user = user;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FMentor',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: AppColors.mPrimary,
          backgroundColor: AppColors.mBackground,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: AppColors.mText),
          ),
        ),
        home:
            //RecommendCourses());
            !_loading
                ? _isFirstLogin
                    ? const GetStarted()
                    : MainPage(
                        userId: _user!.userId,
                        initialPage: 0,
                        isMentor: _user!.isMentor,
                        menteeId: _user!.mentees.isNotEmpty
                            ? _user!.mentees.first.menteeId
                            : null,
                        mentorId: _user!.mentors!.isNotEmpty
                            ? _user!.mentors!.first.mentorId
                            : null,
                      )
                : const Loading());
  }
}
