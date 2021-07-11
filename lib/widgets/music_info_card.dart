import 'package:flutter/material.dart';

import '../models/search_type.dart';

class MusicInfoCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String artistName;
  final String type; // might want to rename search type to something else

  const MusicInfoCard({
    @required this.imageUrl,
    @required this.title,
    @required this.artistName,
    @required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 6.0),
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: ListTile(
          leading: Image.network(imageUrl),
          title: Text(title),
          subtitle: Text(artistName),
          trailing: Text('${type[0].toUpperCase()}${type.substring(1)}'),
        ),
      ),
    );
  }
}
