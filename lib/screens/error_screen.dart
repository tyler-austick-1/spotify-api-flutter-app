import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  ErrorScreen(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 215, 96, 1),
        title: Text(':/'),
      ),
      body: Center(
        child: Text(errorMessage),
      ),
    );
  }
}
