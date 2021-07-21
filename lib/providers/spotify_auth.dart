import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class SpotifyAuth with ChangeNotifier{
  String _token;
  // String _tokenType;
  DateTime _expiryTime;
  Timer _tokenTimer;

  // Checks if we have a valid access token
  bool get isAuth {
    return _token != null && _expiryTime.isAfter(DateTime.now());
  }

  String get token {
    return _token;
  }

  /* 
    Retrieves a valid token from the Spotify API using the client ID and client secret.

    The client id and client secret (separated by a comma) must be converted to a Base64
    string before being passed to the header of the request.

    Once authorisation is complete the _refreshToken method is called so that when the 
    current token expires a new token will automatically be retrieved and updated.

    The token and expiry time retrieved are stored on the device's local storage so that
    a new token does not need to be requested every time the user opens the app as long
    as they have a valid token stored on the device.
  */
  Future<void> authorise() async {
    const _clientId = 'a1e315a6f9a9406c9bdb6d51c5f8e03c';       // INSERT YOUR ID HERE
    const _clientSecret = '6626e9762e9547a69ec729584e604861';   // INSERT YOUR SECRET HERE

    // Yes the above secret has been changed so use your own ;)

    final url = Uri.parse('https://accounts.spotify.com/api/token');

    const stringToEncode = '$_clientId:$_clientSecret';
    final bytes = utf8.encode(stringToEncode);
    final base64String = base64.encode(bytes);

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

  /* 
    Tries to set a valid token by using the token stored on the
    device's local storage (if there is one).
  */
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

  // Requests a new token when the current one expires.
  void _refreshToken() {
    if (_tokenTimer != null) {
      _tokenTimer.cancel();
    }
    final timeToExpiry = _expiryTime.difference(DateTime.now()).inSeconds;
    _tokenTimer = Timer(Duration(seconds: timeToExpiry), authorise);
  }
}
