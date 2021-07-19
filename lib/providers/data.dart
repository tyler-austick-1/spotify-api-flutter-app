import 'package:flutter/foundation.dart';

import '../models/artist.dart';
import '../models/album.dart';
import './spotify_api.dart';
import '../models/track.dart';

/* 
  Class used to store the objects returned from a search query.

  The lists that store the results get updated every time the user
  submits a new search and will notify the listeners to the changes.
*/
class Data with ChangeNotifier {
  SpotifyAPI spotifyAPI;

  Data(this.spotifyAPI);

  void updateSpotifyAPI(SpotifyAPI spotifyAPI) {
    this.spotifyAPI = spotifyAPI;
    notifyListeners();  
  }

  List<dynamic> _retrievedResults = [];

  final List<Album> _retrievedAlbums = [];
  final List<Artist> _retrievedArtists = [];
  final List<Track> _retrievedTracks = [];


  List<dynamic> get results {
    return [..._retrievedResults];
  }

  List<Album> get albums {
    return [..._retrievedAlbums];
  }

  List<Artist> get artists {
    return [..._retrievedArtists];
  }

  List<Track> get tracks {
    return [..._retrievedTracks];
  }

  // Set the retrieved search results from the Spotify API
  void _setSearchResults(List<dynamic> results) {
    _retrievedResults = results;
    sortIntoTypes();
    notifyListeners();
  }

  // Sorts the search results into their respective types (Album, Artist and Track)
  void sortIntoTypes() {
    if (_retrievedResults == null) {
      return;
    }

    _retrievedAlbums.clear();
    _retrievedArtists.clear();
    _retrievedTracks.clear();

    _retrievedResults.forEach((element) { 
      if (element is Album) {
        _retrievedAlbums.add(element);
      } else if (element is Artist) {
        _retrievedArtists.add(element);
      } else if (element is Track) {
        _retrievedTracks.add(element);
      }
    });
  }

  /* 
    Attempts to retrieve the search results from the API.
    Then calls the method to temporarily store the search results.
  */
  Future<void> tryToSearch(String query) async {
    try {
      final searchResultsList = await spotifyAPI.search(query);
      _setSearchResults(searchResultsList);
    } catch (error) {
      throw error;
    }
  }
}