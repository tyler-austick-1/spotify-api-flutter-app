import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../models/album.dart';
import './spotify_api.dart';
import '../models/search_type.dart';

// import '../models/track.dart';

class Data with ChangeNotifier {
  SpotifyAPI spotifyAPI;

  Data(this.spotifyAPI);

  void updateSpotifyAPI(SpotifyAPI spotifyAPI) {
    this.spotifyAPI = spotifyAPI;
  }

  final List<Album> retrievedAlbums = [];
  // final Map<String, Track> retrievedTracks = {};


  List<Album> get albums {
    return [...retrievedAlbums];
  }

  void _addListOfALbums(List<Album> albums) {
    retrievedAlbums.clear();
    retrievedAlbums.addAll(albums);
    notifyListeners();
  }

  Future<void> tryToSearch(String query, List<SearchType> searchTypes) async {  // atm this only works for albums
    try {
      final searchResultsList = await spotifyAPI.search(query, searchTypes);
      _addListOfALbums(searchResultsList);
    } catch (error) {
      throw error;
    }
  }
  // List<Track> get tracks {
  //   return retrievedTracks.entries.map((e) => e.value).toList();
  // }

  // void addTrack(Track track) {
  //   retrievedTracks[track.id] = track;
  //   notifyListeners();
  // }
}