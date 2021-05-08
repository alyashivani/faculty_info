import 'package:flutter/material.dart';

class ConfirmEmail extends StatelessWidget {
  static String id = 'confirm-email';
  final String message;

  const ConfirmEmail({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            message,
            style: TextStyle(color: Colors.grey[850], fontSize: 16),
          ),
        )),
      ),
    );
  }
}
