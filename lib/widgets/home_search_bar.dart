import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_app/providers/data.dart';

import '../models/search_type.dart';
import './custom_search_bar.dart';
import './search_selection_bar.dart';
import '../providers/spotify_api.dart';

class HomeSearchBar extends StatefulWidget {
  @override
  _HomeSearchBarState createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  var _selectedTypes = [SearchType.ALBUM];
  var _enableSearchBar = true;

  void _updateSelectedTypes(List<SearchType> types) {
    _selectedTypes = types;
    setState(() {
      _enableSearchBar = _selectedTypes.isNotEmpty;
    });
  }

  void _trySearch(String query) async {
    if (query.isEmpty) {
      return;
    }
    
    try {
      await Provider.of<Data>(context, listen: false).tryToSearch(query, _selectedTypes);    // call try to search in stored data
    } catch (error) {
      throw error;    // make this display something later
    }

  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(_trySearch, _enableSearchBar),
        SearchSelectionBar(_selectedTypes, _updateSelectedTypes),
      ],
    );
  }
}
