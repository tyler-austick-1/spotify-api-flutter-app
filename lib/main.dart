import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_app/providers/spotify_api.dart';
import 'package:spotify_app/providers/data.dart';
import 'package:spotify_app/screens/album_screen.dart';
import 'package:spotify_app/screens/music_data_screen.dart';

import './providers/spotify_auth.dart';
import './screens/home_screen.dart';
import './screens/loading_screen.dart';
import './screens/connect_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<int, Color> color = {
    50: Color.fromRGBO(30, 215, 96, .1),
    100: Color.fromRGBO(30, 215, 96, .2),
    200: Color.fromRGBO(30, 215, 96, .3),
    300: Color.fromRGBO(30, 215, 96, .4),
    400: Color.fromRGBO(30, 215, 96, .5),
    500: Color.fromRGBO(30, 215, 96, .6),
    600: Color.fromRGBO(30, 215, 96, .7),
    700: Color.fromRGBO(30, 215, 96, .8),
    800: Color.fromRGBO(30, 215, 96, .9),
    900: Color.fromRGBO(30, 215, 96, 1),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SpotifyAuth()),
        ChangeNotifierProxyProvider<SpotifyAuth, SpotifyAPI>(
          create: (ctx) => SpotifyAPI(null),
          update: (ctx, auth, previousAPI) =>
              previousAPI..updateToken(auth.token),
        ),
        ChangeNotifierProxyProvider<SpotifyAPI, Data>(
          create: (ctx) => Data(null),
          update: (ctx, api, previousStoredData) =>
              previousStoredData..updateSpotifyAPI(api),
        )
      ],
      child: Consumer<SpotifyAuth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Spotify Test',
          theme: ThemeData(
            primarySwatch: MaterialColor(0xFF1DB954, color),
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    color: Colors.white,
                  ),
                  headline5: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  headline4: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.black,
                  ),
                ),
          ),
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoAuth(),
                  builder: (_, authSnapshot) =>
                      authSnapshot.connectionState == ConnectionState.waiting
                          ? LoadingScreen('Connecting to Spotify...')
                          : ConnectScreen(),
                ),
          routes: {
            LoadingScreen.routeName: (_) => LoadingScreen(),
            MusicDataScreen.routeName: (_) => MusicDataScreen(),
            AlbumScreen.routeName: (_) => AlbumScreen(),
          },
        ),
      ),
    );
  }
}
