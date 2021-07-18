import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
import 'package:palette_generator/palette_generator.dart';

import './image.dart' as im;

class Album {
  Map<String, String> artists;
  List<im.Image> images;
  String type;
  List<String> availableMarkets;
  // final Map<String, Uri> externalUrls;
  Uri href;
  String id;
  String name;
  // final String
  String releaseDate;
  // final String releaseDatePrecision;
  // final String type;
  // final String spotifyUri;

  Album({
    @required this.artists,
    @required this.images,
    @required this.type,
    // this.availableMarkets,
    // this.externalUrls,
    @required this.href,
    @required this.id,
    @required this.name,
    @required this.releaseDate,
    @required this.availableMarkets,
    // this.releaseDatePrecision,
    // this.type,
    // this.spotifyUri
  });

  Future<Color> getAlbumMainColor() async {
    final ImageProvider imageProvider = hasImages ? NetworkImage(images[0].url) : AssetImage('images/spotify-logo.png');

    try {
      final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
      return paletteGenerator.dominantColor.color;
    } catch (error) {
      return Color.fromRGBO(30, 215, 96, 1);
    }
  }

  String get formattedReleaseDate {
    if (releaseDate != null && releaseDate.length >= 4) {
      return releaseDate.substring(0, 4);
    }

    return 'Unknown release date';
  }

  bool get hasImages {
    return images.isNotEmpty;
  }

  Album.fromJson(Map<String, dynamic> albumData) {
    this.artists = {};
    final artistsList = albumData['artists'] as List<dynamic>;
    
    artistsList.forEach((element) { 
      // final Map<String, String> elementMap = {element['id']: element['name']};
      this.artists[element['id']] = element['name'];
    });
    
    this.images = [];
    final imagesList = albumData['images'] as List<dynamic>;

    imagesList.forEach((element) {
      this.images.add(im.Image.fromJson(element));
    });

    this.availableMarkets = [];
    final marketsList = albumData['available_markets'] as List<dynamic>;

    marketsList.forEach((element) { 
      this.availableMarkets.add(element);
    });

    this.releaseDate = albumData['release_date'];
    this.type = albumData['album_type'];
    this.href = Uri.parse(albumData['href'] as String);
    this.id = albumData['id'];
    this.name = albumData['name'];
  }

  @override
  bool operator ==(other) {
    return other is Album && id == other.id && name == other.name;  // change from href to spotify external url
  }

  @override
  int get hashCode => hash2(id.hashCode, name.hashCode);

  @override
  String toString() {
    var string = "------------------------------------------------------------------\nAlbum:\nid: $id\nname: $name\nhref: $href\nalbum type: $type\n";

    // this.artists.forEach((element) { 
    //   string += element.toString();
    // });

    this.images.forEach((element) { 
      string += element.toString();
    });

    return string;
  }
}
