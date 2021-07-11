import 'package:flutter/material.dart';
import 'package:spotify_app/models/search_type.dart';
import 'package:spotify_app/widgets/selection_bubble.dart';

class SearchSelectionBar extends StatefulWidget {
  final List<SearchType> defaultSelectedTypes;
  final Function updateSelectedTypes;

  SearchSelectionBar(this.defaultSelectedTypes, this.updateSelectedTypes);

  @override
  _SearchSelectionBarState createState() => _SearchSelectionBarState();
}

class _SearchSelectionBarState extends State<SearchSelectionBar> {
  final List<SearchType> _searchTypes = SearchType.values;

  List<SearchType> _currentlySelectedTypes;

  @override
  void initState() {
    _currentlySelectedTypes = widget.defaultSelectedTypes;
    super.initState();
  }

  void _toggleSelectedType(SearchType searchType) {
    setState(() {
      if (_currentlySelectedTypes.contains(searchType)) {
        _currentlySelectedTypes.remove(searchType);
      } else {
        _currentlySelectedTypes.add(searchType);
      }
    });
    
    widget.updateSelectedTypes(_currentlySelectedTypes);
  }

  // void _addSearchType(SearchType searchType) {
  //   setState(() {
  //     _currentlySelectedTypes.add(searchType);
  //   });
  // }

  // void _removeSearchType(SearchType searchType) {
  //   setState(() {
  //     _currentlySelectedTypes.remove(searchType);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(3.0),
      child: Row(
        children: [
          // SelectionBubble(_selectedType, () {}),
          ..._searchTypes.map((searchType) {
            if (searchType != SearchType.ALBUM) {
              return SelectionBubble(searchType, _toggleSelectedType, false, false);
            } 

            return SelectionBubble(searchType, _toggleSelectedType, true, true);

            // UNCOMMENT THIS FOR THE CORRECT LOGIC, THE ABOVE IS FOR TESTING
            // if (_currentlySelectedTypes.contains(searchType)) {
            //   return SelectionBubble(searchType, _toggleSelectedType, true);
            // }

            // return SelectionBubble(searchType, _toggleSelectedType);
          }).toList(),
        ],
      ),
    );
  }
}
