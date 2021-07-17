import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_app/widgets/album_tile.dart';

import '../models/artist.dart';
import '../providers/spotify_api.dart';
import '../models/album.dart';

class ArtistScreen extends StatelessWidget {
  static const routeName = '/artist';

  @override
  Widget build(BuildContext context) {
    final artistObject = ModalRoute.of(context).settings.arguments as Artist;

    final appBar = AppBar(
      title: Text(
        artistObject.name,
        style: Theme.of(context).textTheme.headline6,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: FutureBuilder(
          future: Provider.of<SpotifyAPI>(context, listen: false)
              .getArtistAlbums(artistObject.id),
          builder: (_, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: (snapshot.data as List<Album>).length,
                      itemBuilder: (_, index) {
                        final currentAlbum = (snapshot.data as List<Album>)[index];
                        return AlbumTile(currentAlbum);
                      })),
    );
  }
}
