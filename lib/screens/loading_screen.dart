import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  static const routeName = '/loading';
  final String loadingText;

  LoadingScreen([this.loadingText]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
