import 'package:flutter/foundation.dart';

class Artist {
  // final Map<String, Uri> externalUrls;
  Uri href;
  String id;
  String name;
  String type;
  // final String spotifyUri;

  Artist({
    // this.externalUrls,
    @required this.href,
    @required this.id,
    @required this.name,
    @required this.type,
    // this.spotifyUri,
  });

  Artist.fromJson(Map<String, dynamic> jsonMap) {
    this.href = Uri.parse(jsonMap['href'] as String);
    this.id = jsonMap['id'];
    this.name = jsonMap['name'];
    this.type = jsonMap['type'];
  }

  @override
  String toString() {
    return '------------------------------------------------------------------\nArtist:\nid: $id\nname: $name\ntype: $type\nhref: $href\n';
  }

}
