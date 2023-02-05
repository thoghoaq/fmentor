import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String message;

  NoData({this.message = 'No Data Available'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
