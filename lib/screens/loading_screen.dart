import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  static const routeName = '/loading';
  final String loadingText;

  LoadingScreen([this.loadingText]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 215, 96, 1),
        title: Text('Spotify API Time'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            if (loadingText != null)
              Text(loadingText),
          ],
        ),
      ),
    );
  }
}
