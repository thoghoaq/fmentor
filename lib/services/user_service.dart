import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/request/signin_request_model.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/utils/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User?> getUserById(int? id) async {
    try {
      print("Calling service getUserById...");
      var url = Uri.parse(Path.path + "/users/" + id.toString());
      var response = await http.get(url);
      if (response.statusCode == 200) {
        User _user = User.fromJson(jsonDecode(response.body));
        saveUser(_user);
        return _user;
      }
    } catch (e) {
      print(e.toString());
      log(e.toString());
    }
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(user.toJson()));
  }

  Future<User?> getUser() async {
    print("Calling service getUser...");
    final prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('user');
    if (string != null) {
      print("Calling service getUser success");
      return User.fromJson(json.decode(string));
    }
    return null;
  }

  Future<int> signIn(SignInRequestModel model) async {
    var isMentor = -1;
    var isSuccess = false;
    var requestData = {
      "email": model.email,
      "password": model.password,
    };
    if (kDebugMode) {
      print('Signing...');
    }
    var url = Uri.parse("${Path.path}/users/signin");
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: utf8.encode(json.encode(requestData)),
    );

    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(response.body));
      await saveUser(user);
      List<int> settingsState = [
        user.isMentorNavigation!.canRequestToMentor,
        user.isMentorNavigation!.canSeeSettings,
        user.isMentorNavigation!.canSeePolicy,
        user.isMentorNavigation!.canMakeSchedule,
        user.isMentorNavigation!.canLogout,
      ];
      saveSettingsState(settingsState);
      isSuccess = true;
      isMentor = user.isMentor;
    } else {
      isSuccess = false;
      if (kDebugMode) {
        print('Signin failed');
      }
    }
    return isMentor;
  }

  Future<void> saveSettingsState(List<int> settingsState) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('settingsState', jsonEncode(settingsState));
  }

  Future<void> clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
