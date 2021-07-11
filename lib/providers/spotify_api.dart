import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/album.dart';
import '../models/track.dart';
import '../models/http_exception.dart';
import '../models/search_type.dart';

class SpotifyAPI with ChangeNotifier {
  String _authToken;

  SpotifyAPI(this._authToken);

  void updateToken(String newToken) {
    this._authToken = newToken;
  }

  Future<void> getTrack(String trackId) async {
    final url = Uri.parse('https://api.spotify.com/v1/tracks/$trackId');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_authToken',
      });

      final data = json.decode(response.body);
      // print(data['album']);
      final album = Album.fromJson(data['album']);
      final track = Track.fromJson(album, data);

      print(track.toString());
      
    } catch (error) {
      print(error);
      throw HttpException('Could not retrieve track. Please try again later.');
    }
  }

  Future<List<Album>> search(String query, List<SearchType> searchTypes) async {
    final queryParameters = {
      'q': query,
      'type': _convertSearchTypes(searchTypes),
    };

    final url = Uri.https('api.spotify.com', '/v1/search', queryParameters);
    print(url.query);

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_authToken',
      });

      final responseData = json.decode(response.body);

      final List<Album> albums = [];

      final retrievedAlbums = responseData['albums'];
      final retrievedItems = retrievedAlbums['items'] as List<dynamic>;

      retrievedItems.forEach((element) { 
        final elementAlbum = Album.fromJson(element);

        albums.add(elementAlbum);
      });
      return albums;
      
    } catch (error) {
      throw HttpException('Could not complete search. Please try again later.');
    }
  }

  String _convertSearchTypes(List<SearchType> searchTypes) {
    var result = '';

    searchTypes.forEach((element) { 
      result += (element.name.toLowerCase() + ',');
    });

    result = result.substring(0, result.length-1);

    return result;
  }
}