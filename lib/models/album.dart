import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

import 'image.dart';
import 'artist.dart';

class Album {
  List<Artist> artists;
  List<Image> images;
  String albumType;
  // final List<String> availableMarkets;
  // final Map<String, Uri> externalUrls;
  Uri href;
  String id;
  String name;
  // final String
  // releaseDate; // maybe convert this to DateTime object (the format is yyyy-MM-dd)
  // final String releaseDatePrecision;
  // final String type;
  // final String spotifyUri;

  Album({
    @required this.artists,
    @required this.images,
    @required this.albumType,
    // this.availableMarkets,
    // this.externalUrls,
    @required this.href,
    @required this.id,
    @required this.name,
    // this.releaseDate,
    // this.releaseDatePrecision,
    // this.type,
    // this.spotifyUri
  });

  Album.fromJson(Map<String, dynamic> albumData) {
    this.artists = [];
    final artistsList = albumData['artists'] as List<dynamic>;
    
    artistsList.forEach((element) { 
      this.artists.add(Artist.fromJson(element));
    });
    
    this.images = [];
    final imagesList = albumData['images'] as List<dynamic>;

    imagesList.forEach((element) {
      this.images.add(Image.fromJson(element));
    });

    this.albumType = albumData['album_type'];
    this.href = Uri.parse(albumData['href'] as String);
    this.id = albumData['id'];
    this.name = albumData['name'];
  }

  @override
  bool operator ==(other) {
    return other is Album && id == other.id && href == other.href;
  }

  @override
  int get hashCode => hash2(id.hashCode, href.hashCode);

  @override
  String toString() {
    var string = "------------------------------------------------------------------\nAlbum:\nid: $id\nname: $name\nhref: $href\nalbum type: $albumType\n";

    this.artists.forEach((element) { 
      string += element.toString();
    });

    this.images.forEach((element) { 
      string += element.toString();
    });

    return string;
  }
}
