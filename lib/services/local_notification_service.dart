import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mentoo/screens/meeting_end.dart';
import 'package:mentoo/screens/mentor_meeting_end.dart';
import 'package:mentoo/screens/recommend_courses.dart';
import 'package:mentoo/services/course_service.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (routeFromMessage) async {
      if (routeFromMessage != null) {
        String? route = routeFromMessage.payload;

        if (route == "mentee")
          Get.to(MeetingEnd());
        else if (route!.substring(0, 11) == "recommended") {
          var subString = route.substring(14);
          var courses = await CourseService().getCoursesRecommended(subString);
          Get.to(RecommendCourses(
            courses: courses,
          ));
        } else
          Get.to(MentorMeetingEnded(
            token: route!,
          ));
      }
    });
  }

  // void _onReceiveNotificationResponse(
  //     String? routeFromMessage, BuildContext context) async {
  //   if (routeFromMessage != null) {
  //     if (routeFromMessage == "mentee")
  //       Get.to(MeetingEnd());
  //     else if (routeFromMessage == "mentor")
  //       Get.to(MentorMeetingEnded());
  //     else
  //       Get.to(RecommendCourses());
  //     //Navigator.of(context).pushNamed(route.payload!);
  //     // Navigator.of(context).push(
  //     //   MaterialPageRoute(builder: (context) => RecommendCourses()),
  //     // );
  //   }
  // }

  void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "easyapproach",
        "easyapproach channel",
        channelDescription: "this is our channel",
        importance: Importance.max,
        priority: Priority.high,
      ));
      if (message.notification != null)
        await _notificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: message.data["route"],
        );
      else
        print("null kia");
    } on Exception catch (e) {
      print(e);
    }
  }
}
