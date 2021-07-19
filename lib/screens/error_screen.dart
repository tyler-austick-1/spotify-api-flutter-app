import 'package:flutter/material.dart';

/* 
  This screen will show when an error has occured.
  It displays a custom text in the center of the screen.
*/
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
