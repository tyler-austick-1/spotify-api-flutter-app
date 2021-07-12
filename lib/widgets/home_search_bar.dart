import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/data.dart';
import '../models/search_type.dart';
import './custom_search_bar.dart';

class HomeSearchBar extends StatefulWidget {
  @override
  _HomeSearchBarState createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  var _selectedTypes = [SearchType.ALBUM];
  var _enableSearchBar = true;
  var _isLoading = false;

  Future<void> _trySearch(String query) async {
    if (query.isEmpty) {
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      await Provider.of<Data>(context, listen: false).tryToSearch(query, _selectedTypes);    // call try to search in stored data
    } catch (error) {
      throw error;    // make this display something later
    }

    setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _isLoading ? CustomSearchBar(_trySearch, _enableSearchBar, true) : CustomSearchBar(_trySearch, _enableSearchBar),
      ],
    );
  }
}
