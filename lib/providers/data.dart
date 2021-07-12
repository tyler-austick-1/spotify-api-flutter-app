import 'package:flutter/foundation.dart';

import '../models/artist.dart';
import '../models/album.dart';
import './spotify_api.dart';
import '../models/search_type.dart';
import '../models/track.dart';

// import '../models/track.dart';

class Data with ChangeNotifier {
  SpotifyAPI spotifyAPI;

  Data(this.spotifyAPI);

  void updateSpotifyAPI(SpotifyAPI spotifyAPI) {
    this.spotifyAPI = spotifyAPI;
  }

  List<dynamic> _retrievedResults = [];

  List<Album> _retrievedAlbums = [];
  List<Artist> _retrievedArtists = [];
  List<Track> _retrievedTracks = [];


  List<dynamic> get results {
    return [..._retrievedResults];
  }

  List<Album> get albums {
    return [..._retrievedAlbums];
  }

  void _setSearchResults(List<dynamic> results) {
    _retrievedResults = results;
    notifyListeners();
  }


  void _addListOfALbums(List<Album> albums) {
    _retrievedAlbums.clear();
    _retrievedAlbums.addAll(albums);
    notifyListeners();
  }

  Future<void> tryToSearch(String query, List<SearchType> searchTypes) async {  // atm this only works for albums
    try {
      final searchResultsList = await spotifyAPI.search(query);
      // _addListOfALbums(searchResultsList);
      _setSearchResults(searchResultsList);
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