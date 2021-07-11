import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/album.dart';
import '../models/track.dart';
import '../models/http_exception.dart';

class SpotifyAuth with ChangeNotifier{
  String _token;
  // String _tokenType;
  DateTime _expiryTime;
  Timer _tokenTimer;

  final Set<Album> retrievedAlbums = {};
  final Set<Track> retrievedTracks = {};

  bool get isAuth {
    return _token != null && _expiryTime.isAfter(DateTime.now()); //might need to add null check on expiry time
  }

  String get token {
    return _token;
  }

  Future<void> authorise() async {
    const _clientId = 'a1e315a6f9a9406c9bdb6d51c5f8e03c';
    const _clientSecret = '6626e9762e9547a69ec729584e604861';

    final url = Uri.parse('https://accounts.spotify.com/api/token');

    const stringToEncode = '$_clientId:$_clientSecret';
    final bytes = utf8.encode(stringToEncode);
    final base64String = base64.encode(bytes);

    // print(base64String);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Basic $base64String',
        },
        body: {
          'grant_type': 'client_credentials',
        },
      );

      final responseData = json.decode(response.body);

      _token = responseData['access_token'];
      // _tokenType = responseData['token_type'];
      _expiryTime = DateTime.now().add(Duration(seconds: responseData['expires_in']));

      _refreshToken();
      notifyListeners();

      // save token and expiry time on local device storage
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'expiryTime': _expiryTime.toIso8601String(),
      });

      prefs.setString('userData', userData);

    } catch (error) {
      throw HttpException('Could not authorise app.');
    }
  }

  Future<bool> tryAutoAuth() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('userData')) {
      return false;
    }

    final storedData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryTime = DateTime.parse(storedData['expiryTime']); // converts ISO string to DateTime object

    if (expiryTime.isBefore(DateTime.now())) {
      return false;
    }

    _token = storedData['token'];
    _expiryTime = expiryTime;
    
    notifyListeners();
    _refreshToken();
    
    return true;
  }

  void _refreshToken() {
    if (_tokenTimer != null) {
      _tokenTimer.cancel();
    }
    final timeToExpiry = _expiryTime.difference(DateTime.now()).inSeconds;
    _tokenTimer = Timer(Duration(seconds: timeToExpiry), authorise);
  }
}
