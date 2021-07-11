import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home_search_bar.dart';
import '../widgets/music_info_card.dart';
import '../providers/spotify_auth.dart';
import '../providers/data.dart';
import '../models/search_type.dart';

class HomeScreen extends StatelessWidget {
  Widget _myBottomSheet(bool isConnected, double screenHeight) {
    final textString = isConnected ? 'Connected to Spotify' : 'Disconnected...';

    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.bottomRight,
      child: Text(
        textString,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.black54,
        ),
      ),
      width: double.infinity,
      height: screenHeight * 0.05,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0,
            color: Colors.grey[350],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spotify API Time',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          HomeSearchBar(),
          Expanded(
            child: Consumer<Data>(
              builder: (ctx, data, _) =>
                  ListView.builder(itemCount: data.albums.length, itemBuilder: (ctx, index) {
                    final currentAlbum = data.albums[index];
                    return MusicInfoCard(imageUrl: currentAlbum.images[0].url, title: currentAlbum.name, artistName: currentAlbum.artists[0].name, type: currentAlbum.albumType);
                  }),
            ),
            // child: Center(
            //   child: MusicInfoCard(
            //     imageUrl:
            //         'https://i.scdn.co/image/ab67616d0000b27303598d18d77ffb1c9c250574',
            //     title: 'Broken Machine',
            //     artistName: 'Nothing but Thieves',
            //     type: SearchType.ALBUM,
            //   ),
            // ),
          ),
        ],
      ),
      bottomSheet: Consumer<SpotifyAuth>(
        builder: (_, auth, __) =>
            _myBottomSheet(auth.isAuth, mediaQuery.size.height),
      ),
    );
  }
}
