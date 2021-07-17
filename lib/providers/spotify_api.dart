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

  Future<List<Album>> getArtistAlbums(String artistId) async {
    final url = Uri.parse('https://api.spotify.com/v1/artists/$artistId/albums');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_authToken',
      });

      final responseData = json.decode(response.body);

      final List<Album> resultAlbums = [];
      final retrievedAlbums = responseData['items'] as List<dynamic>;

      retrievedAlbums.forEach((albumJson) { 
        resultAlbums.add(Album.fromJson(albumJson));
      });

      return resultAlbums;
    } catch (error) {
      throw error;
    }
  }

  Future<List<Track>> getAlbumTracks(String albumId) async {
    final url = Uri.parse('https://api.spotify.com/v1/albums/$albumId');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_authToken',
      });

      final responseData = json.decode(response.body);
      final album = Album.fromJson(responseData);

      final retrievedTracks = responseData['tracks'];
      final retrievedTrackItems = retrievedTracks['items'] as List<dynamic>;

      final List<Track> tracks = [];

      retrievedTrackItems.forEach((trackJson) { 
        tracks.add(Track.fromJson(album, trackJson));
      });

      return tracks;

    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, dynamic>> getTrackData(String trackId) async {
    final url = Uri.parse('https://api.spotify.com/v1/tracks/$trackId');

    try {
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $_authToken',
      });

      print('track data ${response.statusCode}');
      final data = json.decode(response.body);
      
      final Map<String, dynamic> resultsMap = {};

      resultsMap['Popularity'] = data['popularity'];
      
      return resultsMap;
      
    } catch (error) {
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

      print('audio features ${response.statusCode}');
      final responseData = json.decode(response.body);
      
      final trackData = await getTrackData(trackId);

      resultMap['Key'] = _convertKey(responseData['key'], responseData['mode']);
      resultMap['Tempo'] = _convertTempo(responseData['tempo']);
      resultMap['Duration'] = _convertDuration(responseData['duration_ms']);
      resultMap.addAll(trackData);
      resultMap['Energy'] = _convertToPercentage(responseData['energy']);
      resultMap['Danceability'] = _convertToPercentage(responseData['danceability']);
      resultMap['Happiness'] = _convertToPercentage(responseData['valence']);
      resultMap['Acousticness'] = _convertToPercentage(responseData['acousticness']);
      resultMap['Instrumentalness'] = _convertToPercentage(responseData['instrumentalness']);
      resultMap['Liveness'] = _convertToPercentage(responseData['liveness']);
      resultMap['Speechiness'] = _convertToPercentage(responseData['speechiness']);

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
      1: 'C♯',
      2: 'D',
      3: 'E♭',
      4: 'E',
      5: 'F',
      6: 'F♯',
      7: 'G',
      8: 'G♯',
      9: 'A',
      10: 'B♭',
      11: 'B',
    };

    const modeConversionTable = {
      0: 'Minor',
      1: 'Major',
    };

    return '${pitchConversionTable[pitchClass]} ${modeConversionTable[mode]}';
  }

  String _convertTempo(num tempo) {
    return '${tempo.round()} bpm';
  }

  String _convertDuration(int duration) {
    final minutes = (duration ~/ 1000) ~/ 60;
    final seconds = (duration ~/ 1000) % 60;

    final convertSeconds = seconds < 10 ? '0$seconds' : '$seconds';

    return '$minutes:$convertSeconds';
  }

  int _convertToPercentage(num value) {
    return (value * 100).round();
  }
}
