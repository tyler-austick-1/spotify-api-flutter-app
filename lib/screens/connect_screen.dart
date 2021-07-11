import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_auth.dart';

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
      appBar: AppBar(),
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
