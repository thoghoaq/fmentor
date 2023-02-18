import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mentoo/models/message.dart';
import 'package:mentoo/models/user.dart';
import 'package:mentoo/services/donation_service.dart';
import 'package:mentoo/services/user_service.dart';
import 'package:mentoo/services/wallet_service.dart';
import 'package:mentoo/theme/colors.dart';
import 'package:mentoo/theme/fonts.dart';
import 'package:mentoo/widgets/loading.dart';

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
  final List<double> _presetDonationAmounts = [10.0, 20.0, 50.0, 100.0];
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
                      "Balance: ${_wallets!.balance}",
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
                          height: 70,
                          child: Chip(
                            label: Text('\$$amount'),
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
                      _description = value;
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
                        var message = await DonationService().donate(_senderId,
                            _receiverId, _donationAmount, _description);
                        // ignore: use_build_context_synchronously
                        setState(() {
                          _loading = false;
                        });
                        // ignore: use_build_context_synchronously
                        showStatusDialog(context, message);
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
