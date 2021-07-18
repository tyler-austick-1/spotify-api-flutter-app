import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import './image.dart' as im;

class Artist {
  // final Map<String, Uri> externalUrls;
  Uri href;
  String id;
  String name;
  String type;
  List<im.Image> images;
  // final String spotifyUri;

  Artist({
    // this.externalUrls,
    @required this.href,
    @required this.id,
    @required this.name,
    @required this.type,
    // this.spotifyUri,
  });

  Future<Color> getArtistMainColor() async {
    final ImageProvider imageProvider = hasImages ? NetworkImage(images[0].url) : AssetImage('images/spotify-logo.png');

    try {
      final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
      return paletteGenerator.dominantColor.color;
    } catch (error) {
      return Color.fromRGBO(30, 215, 96, 1);
    }
  }

  bool get hasImages {
    return images.isNotEmpty;
  }

  Artist.fromJson(Map<String, dynamic> jsonMap) {
    this.href = Uri.parse(jsonMap['href'] as String);

    this.images = [];
    final imagesList = jsonMap['images'] as List<dynamic>;

    imagesList.forEach((element) {
      this.images.add(im.Image.fromJson(element));
    });

    this.id = jsonMap['id'];
    this.name = jsonMap['name'];
    this.type = jsonMap['type'];
  }

  @override
  String toString() {
    return '------------------------------------------------------------------\nArtist:\nid: $id\nname: $name\ntype: $type\nhref: $href\n';
  }
}
