import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/album_tile.dart';
import '../models/artist.dart';
import '../providers/spotify_api.dart';
import '../models/album.dart';

class ArtistScreen extends StatelessWidget {
  static const routeName = '/artist';

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    final artistObject = ModalRoute.of(context).settings.arguments as Artist;

    // final appBar = AppBar(
    //   backgroundColor: Color.fromRGBO(30, 215, 96, 1),
    //   title: Text(
    //     artistObject.name,
    //     style: Theme.of(context).textTheme.headline6,
    //   ),
    // );

    return FutureBuilder(
      future: artistObject.getArtistMainColor(),
      builder: (_, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: snapshot.data as Color,
                title: Text(
                  artistObject.name,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        artistObject.hasImages
                            ? Image.network(
                                artistObject.images[0].url,
                                fit: BoxFit.contain,
                              )
                            : Image.asset(
                                'images/spotify-logo.png',
                                fit: BoxFit.cover,
                              ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 10.0,
                          ),
                          margin: const EdgeInsets.symmetric(
                            // horizontal: 8.0,
                            vertical: 12.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Text(
                            artistObject.name,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    FutureBuilder(
                      future: Provider.of<SpotifyAPI>(context, listen: false)
                          .getArtistAlbums(artistObject.id),
                      builder: (_, snapshot) =>
                          snapshot.connectionState == ConnectionState.waiting
                              ? Flexible(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ...(snapshot.data as Set<Album>)
                                        .map((currentAlbum) =>
                                            AlbumTile(currentAlbum))
                                        .toList()
                                  ],
                                ),
                    ),
                    // : ListView.builder(
                    //     itemCount: (snapshot.data as List<Album>).length,
                    //     itemBuilder: (_, index) {
                    //       final currentAlbum =
                    //           (snapshot.data as List<Album>)[index];
                    //       return AlbumTile(currentAlbum);
                    //     },
                    //   ),
                  ],
                ),
              ),
            ),
    );
  }
}
