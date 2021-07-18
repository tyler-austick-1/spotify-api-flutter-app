import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/spotify_api.dart';
import '../widgets/music_info_card.dart';
import '../models/album.dart';
import '../models/track.dart';

class AlbumScreen extends StatelessWidget {
  static const routeName = '/album';
  // List<Track> albumsTracks = [];

  Widget _constructTrackList(List<Track> tracks) {
    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (_, index) {
        final currentTrack = tracks[index];
        return MusicInfoCard(
          musicObject: currentTrack,
          showImage: false,
          verticalMargin: 0,
          horizontalMargin: 0,
          hasRoundedCorners: false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final albumObject = ModalRoute.of(context).settings.arguments as Album;

    final appBar = AppBar(
      title: Text(
        albumObject.name,
        style: Theme.of(context).textTheme.headline6,
      ),
    );

    final heightWithoutAppBar = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
        future: Provider.of<SpotifyAPI>(context, listen: false)
            .getAlbumTracks(albumObject.id),
        builder: (_, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 17.0),
                          height: heightWithoutAppBar * 0.35,
                          child: albumObject.hasImages
                              ? Image.network(
                                  albumObject.images[0].url,
                                  fit: BoxFit.contain,
                                )
                              : Image.asset(
                                  'images/spotify-logo.png',
                                  fit: BoxFit.contain,
                                ),
                        ),
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                albumObject.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                albumObject.artists.values.toList()[0],
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...(snapshot.data as List<Track>)
                                .map((currentTrack) => MusicInfoCard(
                                      musicObject: currentTrack,
                                      showImage: false,
                                      verticalMargin: 0,
                                      horizontalMargin: 0,
                                      hasRoundedCorners: false,
                                      elevation: 0,
                                    ))
                                .toList()
                          ],
                        ),
                      ],
                    ),
                  ),
        // : _constructTrackList(snapshot.data),
      ),
    );
  }
}
