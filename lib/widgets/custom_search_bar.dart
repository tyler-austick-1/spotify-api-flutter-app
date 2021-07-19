import 'package:flutter/material.dart';

import './loading_button.dart';

/* 
  This widget is a search bar with custom styling.
  The left of the search bar is a TextField and the right has a custom search button.
*/
class CustomSearchBar extends StatefulWidget {
  final Function _executeOnCompleted;
  final bool _isEnabled;
  final bool _isLoading;

  CustomSearchBar(this._executeOnCompleted,
      [this._isEnabled = true, this._isLoading = false]);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 6.0,
        left: 5.0,
        right: 5.0,
        bottom: 1.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                enabled: widget
                    ._isEnabled, 
                onSubmitted: (value) {
                  widget._executeOnCompleted(value);
                },
                controller: _controller,
                decoration: InputDecoration(
                  hintText: widget._isEnabled
                      ? 'Search...'
                      : 'Select at least one type below...',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 2.0,
                  ),
                ),
              ),
            ),
          ),
          widget._isLoading
              ? LoadingButton()
              : Container(
                  width: 40.0,
                  height: 40.0,
                  margin: EdgeInsets.only(
                    right: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: widget._isEnabled
                        ? Color.fromRGBO(30, 215, 96, 1)
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: IconButton(
                    onPressed: !widget._isEnabled
                        ? null
                        : () {
                            widget._executeOnCompleted(_controller.text);
                            FocusScope.of(context)
                                .unfocus(); // closes the keyboard
                          },
                    iconSize:
                        22.0, 
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
