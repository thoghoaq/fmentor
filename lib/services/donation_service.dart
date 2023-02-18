import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mentoo/models/message.dart';
import 'package:mentoo/utils/path.dart';

class DonationService {
  Future<Message> donate(
      int senderId, int receiverId, double ammount, String description) async {
    if (ammount < 1 || ammount > 99999999) {
      return Message(
          statusCode: 404,
          message: "The field ammount must be between 1 and 99999999.");
    }
    final url = Uri.parse("${Path.path}/donation");
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'senderId': senderId,
      'receiverId': receiverId,
      'amount': ammount,
      'description': description,
    });
    final response = await http.post(url, headers: headers, body: body);
    var jsonResponse = json.decode(response.body);
    var messageString = jsonResponse['message'];
    if (kDebugMode) {
      print(messageString);
    }
    Message message =
        Message(statusCode: response.statusCode, message: messageString);
    return message;
  }
}
