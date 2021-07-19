import 'package:flutter/material.dart';

import '../models/album.dart';
import '../screens/album_screen.dart';
import '../screens/artist_screen.dart';
import '../screens/track_screen.dart';
import '../models/track.dart';
import '../models/artist.dart';

/* 
  A custom Card containing a ListTile to display the 
  relevant information of a 'music object' (i.e. Album, Artist and Track).
*/
class MusicInfoCard extends StatelessWidget {
  final dynamic musicObject;
  final bool showImage;
  final double verticalMargin;
  final double horizontalMargin;
  final bool hasRoundedCorners;
  final double elevation;

  const MusicInfoCard({
    @required this.musicObject,
    this.showImage = true,
    this.verticalMargin = 2.0,
    this.horizontalMargin = 6.0,
    this.hasRoundedCorners = true,
    this.elevation = 2.0,
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

  void _navigate(BuildContext ctx) {
    if (musicObject is Track) {
      Navigator.of(ctx).pushNamed(TrackScreen.routeName, arguments: musicObject);
    } else if (musicObject is Album) {
      Navigator.of(ctx).pushNamed(AlbumScreen.routeName, arguments: musicObject);
    } else if (musicObject is Artist) {
      Navigator.of(ctx).pushNamed(ArtistScreen.routeName, arguments: musicObject);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: hasRoundedCorners ? null : Border(),
      margin: EdgeInsets.symmetric(vertical: verticalMargin, horizontal: horizontalMargin),
      elevation: elevation,
      child: InkWell(
        onTap: () => _navigate(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            leading: showImage ? _getLeadingImage() : null,
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
