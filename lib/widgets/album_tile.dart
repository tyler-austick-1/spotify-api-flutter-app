import 'package:flutter/material.dart';

import '../screens/album_screen.dart';
import '../models/album.dart';

/* 
  This widget is used to display an album in the ArtistScreen.
  The left of the Containter contains the album's image while the 
  right side contains a Column with the album: type, name, artist and release year.
*/
class AlbumTile extends StatelessWidget {
  final Album album;

  AlbumTile(this.album);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AlbumScreen.routeName, arguments: album);
      },
      child: Container(
        height: 150,
        width: double.infinity,
        child: Row(
          children: [
            album.hasImages
                ? Image.network(album.images[0].url)
                : Image.asset('images/spotify-logo.png'),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 0.3, color: Colors.black26),
                    bottom: BorderSide(width: 0.3, color: Colors.black26),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${album.type[0].toUpperCase()}${album.type.substring(1)}',
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                    Text(
                      album.name,
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${album.artists.values.toList()[0]} - ${album.formattedReleaseDate}',
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
