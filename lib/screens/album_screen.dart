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
    final albumObject = ModalRoute.of(context).settings.arguments as Album;

    final appBar = AppBar(
      title: Text(
        albumObject.name,
        style: Theme.of(context).textTheme.headline6,
      ),
    );

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
                : _constructTrackList(snapshot.data),
      ),
    );
  }
}
