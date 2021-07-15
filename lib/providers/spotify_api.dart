import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/artist.dart';
import '../models/album.dart';
import '../models/track.dart';
import '../models/http_exception.dart';

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

  Future<Map<String, dynamic>> getAudioFeatures(String trackId) async {
    final url = Uri.parse('https://api.spotify.com/v1/audio-features/$trackId');
    final Map<String, dynamic> resultMap = {};

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_authToken',
      });

      final responseData = json.decode(response.body);

      resultMap['Key'] = _convertKey(responseData['key'], responseData['mode']);
      resultMap['Tempo'] = _convertTempo(responseData['tempo']);
      resultMap['Duration'] = _convertDuration(responseData['duration_ms']);
      resultMap['Energy'] = responseData['energy'];
      resultMap['Danceability'] = responseData['danceability'];
      // add more later

      return resultMap;
    } catch (error) {
      throw error;
    }
  }

  Future<List<dynamic>> search(String query) async {
    final queryParameters = {
      'q': query,
      'type': 'track,artist,album',
    };

    final url = Uri.https('api.spotify.com', '/v1/search', queryParameters);
    print(url.query);

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_authToken',
      });

      final responseData = json.decode(response.body);

      final List<dynamic> results = [];

      final retrievedAlbums = responseData['albums'];
      final retrievedAlbumItems = retrievedAlbums['items'] as List<dynamic>;

      retrievedAlbumItems.forEach((element) {
        final elementAlbum = Album.fromJson(element);

        results.add(elementAlbum);
      });

      final retrievedArtists = responseData['artists'];
      final retrievedArtistItems = retrievedArtists['items'] as List<dynamic>;

      retrievedArtistItems.forEach((element) {
        final elementArtist = Artist.fromJson(element);

        results.add(elementArtist);
      });

      final retrievedTracks = responseData['tracks'];
      final retrievedTrackItems = retrievedTracks['items'] as List<dynamic>;

      retrievedTrackItems.forEach((element) {
        final albumOfTrack = Album.fromJson(element['album']);
        final elementTrack = Track.fromJson(albumOfTrack, element);

        results.add(elementTrack);
      });

      return results;
    } catch (error) {
      throw HttpException('Could not complete search. Please try again later.');
    }
  }

  String _convertKey(int pitchClass, int mode) {
    const pitchConversionTable = {
      0: 'C',
      1: 'C♯(D♭)',
      2: 'D',
      3: 'D♯(E♭)',
      4: 'E',
      5: 'F',
      6: 'F♯(G♭)',
      7: 'G',
      8: 'G♯(A♭)',
      9: 'A',
      10: 'A♯(B♭)',
      11: 'B',
    };

    const modeConversionTable = {
      0: 'Minor',
      1: 'Major',
    };

    return '${pitchConversionTable[pitchClass]} ${modeConversionTable[mode]}';
  }

  String _convertTempo(double tempo) {
    return '${tempo.round()} bpm';
  }

  String _convertDuration(int duration) {
    final minutes = (duration ~/ 1000) ~/ 60;
    final seconds = (duration ~/ 1000) % 60;

    final convertSeconds = seconds < 10 ? '0$seconds' : '$seconds';

    return '$minutes:$convertSeconds';
  }
}
