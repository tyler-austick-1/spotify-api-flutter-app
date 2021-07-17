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
  ];

  Widget _getCorrectImage(Track track) {
    if (track.album.hasImages) {
      return Image.network(
        track.album.images[0].url,
        fit: BoxFit.cover,
      );
    }

    return Image.asset(
      'images/spotify-logo.png',
      fit: BoxFit.cover,
    );
  }

  Map<String, dynamic> _onlyIndicatorEntries(Map<String, dynamic> map) {
    Map<String, dynamic> copy = Map.from(map);
    copy.removeWhere((key, value) => noIndicatorList.contains(key));
    return copy;
  }

  @override
  Widget build(BuildContext context) {
    final track = ModalRoute.of(context).settings.arguments as Track;
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      title: Text(
        track.name,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
    final heightWithoutAppBar = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final squareHeight = (mediaQuery.size.height -
            appBar.preferredSize.height -
            mediaQuery.padding.top -
            1) /
        2;

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: Provider.of<SpotifyAPI>(context, listen: false)
            .getAudioFeatures(track.id),
        builder: (ctx, snapShot) =>
            snapShot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : (snapShot.data == null
                    ? Center(
                        child: Text(
                            'Could not retrieve track data. Please try again later.'),
                      )
                    : SingleChildScrollView(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: heightWithoutAppBar * 0.3,
                              width: double.infinity,
                              child: _getCorrectImage(track),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                track.name,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                DataTile(
                                  title: 'Key',
                                  value: (snapShot.data
                                      as Map<String, dynamic>)['Key'],
                                  height: 120,
                                  width: 120,
                                  elevation: 4.0,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      DataTile(
                                        title: 'Tempo',
                                        value: (snapShot.data
                                            as Map<String, dynamic>)['Tempo'],
                                        height: 55,
                                        elevation: 4.0,
                                      ),
                                      DataTile(
                                        title: 'Duration',
                                        value: (snapShot.data
                                            as Map<String, dynamic>)['Duration'],
                                        height: 55,
                                        elevation: 4.0,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: GridView.count(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: 2,
                                children: [
                                  ...(_onlyIndicatorEntries(snapShot.data as Map<String, dynamic>))
                                      .entries
                                      .map((e) {
                                    return DataTile(
                                      title: e.key,
                                      value: e.value,
                                      width: heightWithoutAppBar * 0.3,
                                      height: heightWithoutAppBar * 0.3,
                                      elevation: 0.5,
                                      hasProgressBar:
                                          !(noIndicatorList.contains(e.key)),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ],
                        ),
                    )),
      ),
    );
  }
}
