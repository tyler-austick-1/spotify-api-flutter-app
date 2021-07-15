import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/artist.dart';
import '../models/search_type.dart';
import '../widgets/selection_bar.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/music_info_card.dart';
import '../providers/data.dart';
import '../models/track.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedType = SearchType.ALL;

  void _setSelectedType(int index) {
    setState(() {
      _selectedType = SearchType.values.toList()[index];
    });
  }

  List<dynamic> _getCorrectList(Data data) {
    switch (_selectedType) {
      case SearchType.ALL:
        return data.results;
        break;
      case SearchType.ALBUM:
        return data.albums;
        break;
      case SearchType.ARTIST:
        return data.artists;
        break;
      case SearchType.TRACK:
        return data.tracks;
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spotify API Time',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Column(
        children: [
          HomeSearchBar(),
          // SearchSelectionBar(_selectedType, _setSelectedType),
          Center(
            child: SelectionBar(
              labels: SearchType.values.map((e) => e.name).toList(),
              onSelectionUpdated: _setSelectedType,
              selectedTabColor: Theme.of(context).primaryColor,
              textColor: Colors.black,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Consumer<Data>(
              builder: (ctx, data, _) {
                return ListView.builder(
                  itemCount: _getCorrectList(data).length,
                  itemBuilder: (ctx, index) {
                    final currentResult = _getCorrectList(data)[index];
                    return MusicInfoCard(
                      musicObject: currentResult,
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
