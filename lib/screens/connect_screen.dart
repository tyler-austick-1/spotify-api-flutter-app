import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_auth.dart';

/* 
  This screen will attempt to authorise the app (from the SpotifyAPI provider)
  and show a CircularProgressIndicator and text to display to the user.
*/
class ConnectScreen extends StatefulWidget {
  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => Provider.of<SpotifyAuth>(context, listen: false).authorise());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color.fromRGBO(30, 215, 96, 1),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text('Attempting to connect to Spotify...'),
          ],
        ),
      ),
    );
  }
}
