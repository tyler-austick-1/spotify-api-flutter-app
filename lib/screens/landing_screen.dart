import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_auth.dart';

class LandingScreen extends StatelessWidget {

  void _attemptConnect(BuildContext ctx) async {
      final sm = ScaffoldMessenger.of(ctx);

      try {
        await Provider.of<SpotifyAuth>(ctx, listen: false).authorise();
      } catch (error) {
        sm.showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      }
    }

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
            Text('Press button to connect to the Spotify API'),
            ElevatedButton(
              onPressed: () => _attemptConnect(context),
              child: Text('Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
