import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/spotify_api.dart';
import './providers/data.dart';
import './screens/album_screen.dart';
import './screens/artist_screen.dart';
import 'screens/track_screen.dart';
import './providers/spotify_auth.dart';
import './screens/home_screen.dart';
import './screens/loading_screen.dart';
import './screens/connect_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            accentColor: Colors.white,
            textTheme: ThemeData.dark().textTheme.copyWith(
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
            /* dark theme settings */
          ),
          themeMode: ThemeMode.dark,
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
            TrackScreen.routeName: (_) => TrackScreen(),
            AlbumScreen.routeName: (_) => AlbumScreen(),
            ArtistScreen.routeName: (_) => ArtistScreen(),
          },
        ),
      ),
    );
  }
}
