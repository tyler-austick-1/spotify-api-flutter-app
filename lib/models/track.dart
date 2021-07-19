import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

import './album.dart';

/* 
  Defines the proporties for a Track.

  Note that the Track object does not currently store all the possible
  data received from a Spotify API Track Object. These fields have been
  commented out for ease of expanding later.

  To see what the Spotify API's Track Object returns see https://developer.spotify.com/documentation/web-api/reference/#objects-index
*/
class Track {
  Album album;
  Map<String, String> artists;
  // final List<String> availableMarkets;
  // final int discNumber;
  // final int durationInMilliseconds;
  bool isExplicit;
  // final Map<String, Object> externalIds;
  // final Map<String, Uri> externalUrls;
  Uri href;
  String id;
  // final bool isLocal;
  String name;
  // final int popularity;
  // final Uri previewUrl;
  // final int trackNumber;
  String type;
  // final String spotifyUri;

  Track(
      {@required this.album,
      @required this.artists,
      // this.availableMarkets,
      // this.discNumber,
      // this.durationInMilliseconds,
      @required this.isExplicit,
      // this.externalIds,
      // this.externalUrls,
      @required this.href,
      @required this.id,
      // this.isLocal,
      @required this.name,
      @required this.type,
      // this.popularity,
      // this.previewUrl,
      // this.trackNumber,
      // this.spotifyUri
      });

  // Uses Palette Generator package to find the most dominant color of the track's album's cover image
  Future<Color> getTrackMainColor() async {
    try {
      final Color albumMainColor = await album.getAlbumMainColor();
      return albumMainColor;
    } catch (error) {
      return Color.fromRGBO(30, 215, 96, 1);
    }
  }

  /*
    Initialises the fields of a Track object from the json data that
    is retrieved from the Spotify API.
    This also takes in an album object that the track is from.
  */
  Track.fromJson(Album album, Map<String, dynamic> trackData) {
    this.album = album;

    this.artists = {};
    final artistsList = trackData['artists'] as List<dynamic>;
    
    artistsList.forEach((element) { 
      this.artists[element['id']] = element['name'];
    });

    this.isExplicit = trackData['explicit'];
    this.href = Uri.parse(trackData['href'] as String);
    this.id = trackData['id'];
    this.name = trackData['name'];
    this.type = trackData['type'];
  }

  @override
  bool operator ==(other) {
    return other is Track && id == other.id && href == other.href;
  }

  @override
  int get hashCode => hash2(id.hashCode, href.hashCode);

  @override
  String toString() {
    var string = "------------------------------------------------------------------\nTrack:\nid: $id\nname: $name\nhref: $href\nisExplicit: $isExplicit\n";
    string += this.album.toString();
    
    return string;
  }
}
