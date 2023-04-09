import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/message.dart';
import 'package:mentoo/models/request/payment_request_model.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/screens/payment.dart';
import 'package:mentoo/services/donation_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/services/wallet_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/widgets/loading.dart';
import 'package:http/http.dart' as http;

class DonationPage extends StatefulWidget {
  final int receiverId;

  const DonationPage({super.key, required this.receiverId});
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  Wallet? _wallets;
  bool _loading = true;
  late int _senderId;
  late int _receiverId;
  double _donationAmount = 0.0;
  String _description = "";
  final List<double> _presetDonationAmounts = [
    10000.0,
    20000.0,
    50000.0,
    100000.0
  ];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    getSenderId();
    _receiverId = widget.receiverId;
    super.initState();
  }

  getSenderId() async {
    var user = await UserService().getUser();
    if (user == null) {
      return;
    }
    _wallets =
        await WalletService().getWalletById(user.wallets!.first.walletId);
    _senderId = user.userId;
    setState(() {
      _loading = false;
    });
  }

  _pay(PaymentRequestModel model) async {
    var response = await _createNewPayment(model);
    if (response!.statusCode == 500) {
      throw Exception("Can not pay");
    }
    return response.body;
  }

  Future<http.Response?> _createNewPayment(PaymentRequestModel model) async {
    String apiUrl = 'https://dev-empire-api.azurewebsites.net/api/v1/payment';
    final response = await http.post(Uri.parse(apiUrl),
        body: jsonEncode({
          'orderType': model.orderType,
          'amount': model.amount,
          'orderDescription': model.orderDescription,
          'name': model.name
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJqdGkiOiIyZjk1OWMzNC00ZDA4LTQ4OTgtYTU4Mi1iOTQwNGFlMjE0ODgiLCJ1bmlxdWVfbmFtZSI6IlRow7RuZyBIb8OgbmciLCJuYW1laWQiOiI5Iiwicm9sZSI6IlVTIiwibmJmIjoxNjgxMDI1NjIxLCJleHAiOjE3MTI2NDgwMjEsImlhdCI6MTY4MTAyNTYyMX0.89zScQ3cmmmBEef-ZDG3VnA3gPWH4yG_Ezsp1UvKAs4'
        });
    if (response.statusCode == 200) {
      log('Payment data sent successfully');
    } else {
      log('Error sending payment data: ${response.statusCode}');
    }
    return response;
  }

  _onCallBackFromPayment() async {
    var message = await DonationService()
        .donate(_senderId, _receiverId, _donationAmount, _description);
    // ignore: use_build_context_synchronously
    setState(() {
      _loading = false;
    });
    // ignore: use_build_context_synchronously
    showStatusDialog(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.black,
                onPressed: () => Get.back(),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              titleTextStyle: AppFonts.medium(30, AppColors.mDarkPurple),
              title: const Text(
                'Donate',
              ),
              actions: [
                Center(
                  child: Container(
                    width: 160,
                    height: 35,
                    decoration: const BoxDecoration(
                        color: AppColors.mLightRed,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Center(
                        child: Text(
                      "Balance: ${_wallets!.balance}đ",
                      style: const TextStyle(color: Colors.black),
                    )),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'Enter the amount',
                      style: AppFonts.medium(20, AppColors.mDarkPurple),
                    ),
                  )),
                  Container(
                    height: 129,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.mDarkPurple, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30))),
                    child: Center(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: AppColors.mDarkPurple,
                        style: const TextStyle(
                            fontSize: 50.0, color: AppColors.mDarkPurple),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _donationAmount = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text('Select a pre-defined amount:'),
                  Wrap(
                    spacing: 8.0,
                    children: _presetDonationAmounts.map((amount) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _donationAmount = amount;
                            _controller.text = _donationAmount.toString();
                          });
                        },
                        child: SizedBox(
                          height: 40,
                          child: Chip(
                            label: Text('${amount}đ'),
                            backgroundColor: _donationAmount == amount
                                ? AppColors.mLightPurple
                                : Colors.grey[300],
                            labelStyle: TextStyle(
                              color: _donationAmount == amount
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  TextField(
                    onChanged: (value) {
                      _description = 'DN-$_receiverId-VNPay-$value';
                    },
                    keyboardType: TextInputType.multiline,
                    minLines: 7,
                    maxLines: 10,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: "Type your message",
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: AppColors.mDarkPurple,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 2,
                          color: AppColors.mDarkPurple,
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      filled: true,
                      // fillColor: AppColors.grayColor,
                      // focusColor: AppColors.grayColor,
                      // hoverColor: AppColors.grayColor,
                      //labelText: lable,
                      labelStyle: AppFonts.medium(16, AppColors.mText),
                      //errorText: 'Error message',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          shadowColor: MaterialStateColor.resolveWith(
                              (states) => Colors.transparent),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => const Color(0xff36894D))),
                      onPressed: () async {
                        setState(() {
                          _loading = true;
                        });
                        PaymentRequestModel paymentRequestModel =
                            PaymentRequestModel(
                                amount: _donationAmount,
                                name: 'Donation',
                                orderDescription: 'Donation',
                                orderType: 'VNpay');
                        var responsePayment = await _pay(paymentRequestModel);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PaymenPage(
                            url: responsePayment,
                            callback: _onCallBackFromPayment,
                          ),
                        ));
                      },
                      child: Text(
                        'Donate',
                        style: AppFonts.medium(24, Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void showStatusDialog(BuildContext context, Message message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message.statusCode == 200
              ? 'Donation Successful'
              : 'Donation Failed'),
          content: Text(message.statusCode == 200
              ? 'Thank you for your donation!'
              : message.message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
