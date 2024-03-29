import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/request/signin_request_model.dart';
import 'package:mentoo/models/request/user_request_model.dart';
import 'package:mentoo/models/specialty.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/models/view/sign_up_view.dart';
import 'package:mentoo/screens/sign_up.dart';
import 'package:mentoo/utils/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User?> getUserById(int? id) async {
    try {
      if (kDebugMode) {
        print("Calling service getUserById...");
      }
      var url = Uri.parse("${Path.path}/users/$id");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        User user = User.fromJson(jsonDecode(response.body));
        saveUser(user);
        return user;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(user.toJson()));
  }

  Future<User?> getUser() async {
    if (kDebugMode) {
      print("Calling service getUser...");
    }
    final prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('user');
    if (string != null) {
      if (kDebugMode) {
        print("Calling service getUser success");
      }
      return User.fromJson(json.decode(string));
    }
    return null;
  }

  Future<User?> signIn(SignInRequestModel model) async {
    var token = await FirebaseMessaging.instance.getToken();
    print("token: " + token.toString());
    User? user;
    var requestData = {
      "email": model.email,
      "password": model.password,
    };
    if (kDebugMode) {
      print('Signing...');
    }
    var url = Uri.parse("${Path.path}/users/signin?token=" + token.toString());
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(requestData),
    );

    if (response.statusCode == 200) {
      user = User.fromJson(jsonDecode(response.body));
      await saveUser(user);
      List<int> settingsState = [
        user.isMentorNavigation!.canRequestToMentor,
        user.isMentorNavigation!.canSeeSettings,
        user.isMentorNavigation!.canSeePolicy,
        user.isMentorNavigation!.canMakeSchedule,
        user.isMentorNavigation!.canLogout,
      ];
      saveSettingsState(settingsState);
      return user;
    } else {
      if (kDebugMode) {
        print('Signin failed');
      }
    }
    return user;
  }

  Future<User?> signUp(SignUpModel signUp) async {
    var url = Uri.parse(Path.path + "/users/sign-up");
    var response = await http.post(url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
        body: jsonEncode(signUp));

    if (response.statusCode == 200) {
      User _user = User.fromJson(jsonDecode(response.body));
      return _user;
    } else
      throw new Exception(response.body);
  }

  Future<bool?> addSpecialties(List<String?> specialties, int id) async {
    try {
      var url =
          Uri.parse(Path.path + "/users/add-specialties/" + id.toString());
      var response = await http.post(url,
          headers: {"accept": "text/plain", "Content-Type": "application/json"},
          body: jsonEncode(specialties));

      if (response.statusCode == 200) {
        bool isAdd = (jsonDecode(response.body));
        return isAdd;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> saveSettingsState(List<int> settingsState) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('settingsState', jsonEncode(settingsState));
  }

  Future<void> clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<User?> updateUser(UserRequestModel user, int id) async {
    var url = Uri.parse(Path.path + "/users/" + id.toString());
    var response = await http.put(url,
        headers: {"accept": "text/plain", "Content-Type": "application/json"},
        body: jsonEncode(user));

    if (response.statusCode == 200) {
      User _user = User.fromJson(jsonDecode(response.body));
      return _user;
    } else
      throw Exception(response.body);
  }
}
