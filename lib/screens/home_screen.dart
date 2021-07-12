import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_app/models/artist.dart';

import '../widgets/home_search_bar.dart';
import '../widgets/music_info_card.dart';
import '../providers/spotify_auth.dart';
import '../providers/data.dart';
import '../models/track.dart';

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
                itemCount: data.results.length,
                itemBuilder: (ctx, index) {
                  final currentResult = data.results[index];
                  return MusicInfoCard(
                    image: currentResult is Track
                        ? Image.network(currentResult.album.images[0].url)  // a Track uses its album's image
                        : (currentResult.hasImages
                            ? Image.network(currentResult.images[0].url)
                            : Image.asset('images/spotify-logo.png')),    // uses default spotify logo if no images are found
                    title: currentResult.name,
                    artistName: currentResult is Artist
                        ? ''
                        : currentResult.artists.values.toList()[0],
                    type: currentResult.type,
                  );
                  // return MusicInfoCard(
                  //     // imageUrl: currentResult is Track ? currentResult.album.images[0].url :  currentResult.images[0].url,
                  //     imageUrl: currentResult.images[0].url,
                  //     title: currentResult.name,
                  //     // artistName: currentResult is Artist ? '' : currentResult.artists[0].name,
                  //     artistName: currentResult.artists.values.toList()[0],
                  //     // type: currentResult.type);
                  //     type: currentResult.albumType);
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
