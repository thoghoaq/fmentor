import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/user.dart';
import 'package:mentoo/utils/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User?> getUserById(int id) async {
    try {
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
    final prefs = await SharedPreferences.getInstance();
    final string = prefs.getString('user');
    if (string != null) {
      return User.fromJson(json.decode(string));
    }
    return null;
  }
}
