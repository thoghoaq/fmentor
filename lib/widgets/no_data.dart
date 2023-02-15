import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String message;

  const NoData({super.key, this.message = 'No Data Available'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
