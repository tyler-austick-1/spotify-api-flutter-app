# Spotify API Flutter App

A flutter app written in dart which uses the [Spotify Web API](https://developer.spotify.com/documentation/web-api/)
to:

- [Search Spotify](https://developer.spotify.com/documentation/web-api/reference/#category-search) to find albums, artists and tracks from a query
- [Retrieve the tracks of an album](https://developer.spotify.com/documentation/web-api/reference/#category-tracks)
- [Retrieve the albums of an artist](https://developer.spotify.com/documentation/web-api/reference/#category-artists)
- Retrieve the [popularity of a track](https://developer.spotify.com/documentation/web-api/reference/#category-tracks) and [audio features](https://developer.spotify.com/documentation/web-api/reference/#category-tracks) (e.g. key, tempo, danceability, etc.)

and of course to present the data with a nice user interface :)

## Getting Started

The app currently uses the [Client Credentials Flow](https://developer.spotify.com/documentation/general/guides/authorization-guide/#client-credentials-flow) to get an access token from Spotify. This means that the user does not need to login to a Spotify account to use the app. If you want to adjust the authorisation code to work with your own project, all you need to do is change the _clientId and _clientSecret constants in the authorise method of the spotify_auth.dart file.

Not sure where to find your client ID and client secret? Go to the [Spotify developer dashboard](https://developer.spotify.com/dashboard/), log in with your spotify account and create a new application.

## How the app looks

### Home screen