import 'package:flutter/material.dart';
import 'package:spotify_app/screens/music_data_screen.dart';

import '../models/track.dart';
import '../models/artist.dart';

class MusicInfoCard extends StatelessWidget {
  final dynamic musicObject;

  const MusicInfoCard({
    @required this.musicObject,
  });

  Widget _getLeadingImage() {
    // uses the track's album's image
    if (musicObject is Track && musicObject.album.hasImages) {
      return Image.network(musicObject.album.images[0].url);
    }
    // uses its own image (for artists and albums)
    if (musicObject.hasImages) {
      return Image.network(musicObject.images[0].url);
    }
    // no images were found so uses placeholder image
    return Image.asset('images/spotify-logo.png');
  }

  Widget _getSubtitle() {
    if (musicObject is Artist) {
      return Text('');
    }

    return Text(musicObject.artists.values
        .toList()[0]); // convert this to all artists names later
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      elevation: 2.0,
      child: InkWell(
        onTap: musicObject is Track ? () {
          Navigator.of(context).pushNamed(MusicDataScreen.routeName, arguments: musicObject);
        } : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            leading: _getLeadingImage(),
            title: Text(musicObject.name),
            subtitle: _getSubtitle(),
            trailing: Text(
                '${musicObject.type[0].toUpperCase()}${musicObject.type.substring(1)}'),
          ),
        ),
      ),
    );
  }
}
