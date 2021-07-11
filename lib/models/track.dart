import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'package:spotify_app/models/album.dart';
import 'package:spotify_app/models/artist.dart';

class Track {
  Album album;
  List<Artist> artists;
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
  // final String type;
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
      // this.popularity,
      // this.previewUrl,
      // this.trackNumber,
      // this.type,
      // this.spotifyUri
      });

  Track.fromJson(Album album, Map<String, dynamic> trackData) {
    this.album = album;

    this.artists = [];
    final artistsList = trackData['artists'] as List<dynamic>;
    
    artistsList.forEach((element) { 
      this.artists.add(Artist.fromJson(element));
    });

    this.isExplicit = trackData['explicit'];
    this.href = Uri.parse(trackData['href'] as String);
    this.id = trackData['id'];
    this.name = trackData['name'];
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
    
    this.artists.forEach((element) {
      string += element.toString();
    });

    return string;
  }
}
