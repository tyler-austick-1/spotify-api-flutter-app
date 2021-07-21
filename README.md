# Spotify API Flutter App

## Contents

- (Description)[#description]
- (Getting Started)[#getting-started]
- (The User Interface)[#the-user-interface]
  - (Home Screen)[#home-screen]
  - (Artist Screen)[#artist-screen]
  - (Album Screen)[#album-screen]
  - (Track Screen)[#track-screen]

## Description

A flutter app written in dart which uses the [Spotify Web API](https://developer.spotify.com/documentation/web-api/)
to:

- [Search Spotify](https://developer.spotify.com/documentation/web-api/reference/#category-search) to find albums, artists and tracks from a query
- [Retrieve the tracks of an album](https://developer.spotify.com/documentation/web-api/reference/#category-tracks)
- [Retrieve the albums of an artist](https://developer.spotify.com/documentation/web-api/reference/#category-artists)
- Retrieve the [popularity of a track](https://developer.spotify.com/documentation/web-api/reference/#category-tracks) and [audio features](https://developer.spotify.com/documentation/web-api/reference/#category-tracks) (e.g. key, tempo, danceability, etc.)

and of course to present the data with a nice user interface!

## Getting Started

The app currently uses the [Client Credentials Flow](https://developer.spotify.com/documentation/general/guides/authorization-guide/#client-credentials-flow) to get an access token from Spotify. This means that the user does not need to login to a Spotify account to use the app. If you want to adjust the authorisation code to work with your own project, all you need to do is change the _clientId and _clientSecret constants in the authorise method of the spotify_auth.dart file.

Not sure where to find your client ID and client secret? Go to the [Spotify developer dashboard](https://developer.spotify.com/dashboard/), log in with your spotify account and create a new application.

## The User Interface

### Home Screen

<img src="https://github.com/tyler-austick-1/spotify-api-flutter-app/blob/main/images/home_screen.jpg" alt="Home screen" width="50%" height="50%"/>

The home screen has a search bar where the user enters their query and results are displayed underneath in a scrollable ListView. There is also a selection bar below the search bar so that results can be filtered by albums, artists and tracks.

### Artist Screen

<p float="left">
  <img src="https://github.com/tyler-austick-1/spotify-api-flutter-app/blob/main/images/artist_screen_1.jpg" alt="Artist screen 1" width="50%" height="50%"/>
  <img src="https://github.com/tyler-austick-1/spotify-api-flutter-app/blob/main/images/artist_screen_2.jpg" alt="Artist screen 2" width="50%" height="50%"/> 
</p>

Once an artist tile is tapped on from the (Home screen)[#home-screen] this screen is displayed to the user which shows all of the artist's albums.

### Album Screen

<img src="https://github.com/tyler-austick-1/spotify-api-flutter-app/blob/main/images/album_screen.jpg" alt="Album screen" width="50%" height="50%"/>

This screen is displayed from tapping on an album tile from the (Home screen)[#home-screen] or (Artist screen)[#artist-screen]

### Track Screen

<p float="left">
  <img src="https://github.com/tyler-austick-1/spotify-api-flutter-app/blob/main/images/track_screen_1.jpg" alt="Track screen 1" width="50%" height="50%"/>
  <img src="https://github.com/tyler-austick-1/spotify-api-flutter-app/blob/main/images/track_screen_2.jpg" alt="Track screen 2" width="50%" height="50%"/> 
</p>

Now this is the interesting screen of the app where the data about a track is displayed. This is the main purpose of the app where musicians can quickly look up the key or tempo of a song or just to see how different tracks compare on metrics such as happiness and danceability. This screen is displayed from tapping on a track tile on the (Home screen)[#home-screen] or (Album screen)[#album-screen]