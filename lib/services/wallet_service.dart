import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mentoo/models/user.dart';
import 'package:http/http.dart' as http;

import '../utils/path.dart';

class WalletService {
  Future<Wallet?> getWalletById(int id) async {
    try {
      var url = Uri.parse("${Path.path}/wallets/$id");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final Wallet wallet = Wallet.fromJson(jsonDecode(response.body));
        return wallet;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      log(e.toString());
    }
    return null;
  }
}
