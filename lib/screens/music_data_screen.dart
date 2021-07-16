import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_api.dart';
import '../widgets/data_tile.dart';
import '../models/track.dart';

// look at this for UI inspo https://tunebat.com/Info/Broken-Machine-Nothing-But-Thieves/1lpxUd0kkSbVbYoUS7hLJJ
// use get a track from the API to get more data that the above link uses

class MusicDataScreen extends StatelessWidget {
  static const routeName = '/music-data';
  static const noIndicatorList = [
    'Key',
    'Tempo',
    'Duration',
    'Loudness',
  ];

  @override
  Widget build(BuildContext context) {
    final musicObject = ModalRoute.of(context).settings.arguments as Track;
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text(
        musicObject.name,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
    final squareHeight = (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top -
            1) /
        2;

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: Provider.of<SpotifyAPI>(context, listen: false)
            .getAudioFeatures(musicObject.id),
        builder: (ctx, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  ...(snapShot.data as Map<String, dynamic>).entries.map((e) {
                    return DataTile(
                      title: e.key,
                      value: e.value,
                      height: squareHeight,
                      hasProgressBar: !(noIndicatorList.contains(e.key)),
                    );
                  }).toList(),
                ],
              ),
      ),
    );
  }
}
