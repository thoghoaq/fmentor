import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mentoo/models/payment_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymenPage extends StatefulWidget {
  final Function callback;
  final String url;

  const PaymenPage({Key? key, required this.url, required this.callback})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PaymenPageState createState() => _PaymenPageState();
}

class _PaymenPageState extends State<PaymenPage> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _controller = controller;
          },
          onPageFinished: (String url) async {
            final String json =
                // ignore: deprecated_member_use
                await _controller.evaluateJavascript('document.body.innerText');
            if (isJson(json)) {
              final decoded = jsonDecode(json);
              log(decoded);
              // Process the decoded JSON data here
              try {
                PaymentResponseModel paymentResponseModel =
                    PaymentResponseModel.fromJson(jsonDecode(decoded));
                log(paymentResponseModel.transactionId);
                // ignore: unrelated_type_equality_checks
                if (paymentResponseModel.vnPayResponseCode == "00" &&
                    paymentResponseModel.success == true) {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  widget.callback();
                } else {
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  log("Payment failed");
                  // ignore: use_build_context_synchronously
                }
              } catch (e) {
                e.toString();
                return;
              }
            }
          },
        ),
      ),
    );
  }
}

bool isJson(String str) {
  try {
    json.decode(str);
    return true;
  } catch (_) {
    return false;
  }
}
