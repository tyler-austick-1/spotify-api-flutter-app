import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home_search_bar.dart';
import '../widgets/music_info_card.dart';
import '../providers/spotify_auth.dart';
import '../providers/data.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Consumer<Data>(
              builder: (ctx, data, _) => ListView.builder(
                itemCount: data.albums.length,
                itemBuilder: (ctx, index) {
                  final currentAlbum = data.albums[index];
                  return MusicInfoCard(
                      imageUrl: currentAlbum.images[0].url,
                      title: currentAlbum.name,
                      artistName: currentAlbum.artists[0].name,
                      type: currentAlbum.albumType);
                },
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
