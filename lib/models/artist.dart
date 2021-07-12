import 'package:flutter/foundation.dart';

import './image.dart';

class Artist {
  // final Map<String, Uri> externalUrls;
  Uri href;
  String id;
  String name;
  String type;
  List<Image> images;
  // final String spotifyUri;

  Artist({
    // this.externalUrls,
    @required this.href,
    @required this.id,
    @required this.name,
    @required this.type,
    // this.spotifyUri,
  });

  bool get hasImages {
    return images.isNotEmpty;
  }

  Artist.fromJson(Map<String, dynamic> jsonMap) {
    this.href = Uri.parse(jsonMap['href'] as String);

    this.images = [];
    final imagesList = jsonMap['images'] as List<dynamic>;

    imagesList.forEach((element) {
      this.images.add(Image.fromJson(element));
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
