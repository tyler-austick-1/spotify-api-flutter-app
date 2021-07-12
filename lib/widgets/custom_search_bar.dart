import 'package:flutter/material.dart';

import './loading_button.dart';

class CustomSearchBar extends StatefulWidget {
  final Function _executeOnCompleted;
  final bool _isEnabled;
  final bool _isLoading;

  CustomSearchBar(this._executeOnCompleted, [this._isEnabled = true, this._isLoading = false]);

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
        border: Border.all(
          width: 1.0,
          color: Colors.grey[400],
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: TextField(    
                enabled: widget._isEnabled,                                 // MIGHT BE ABLE TO USE ON CHANGED TO HAVE DYNAMIC SEARCH BAR
                onSubmitted: (value) {
                  widget._executeOnCompleted(value);
                  // _controller.clear();
                },
                controller: _controller,
                decoration: InputDecoration(
                  hintText: widget._isEnabled ? 'Search...' : 'Select at least one type below...',
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
          widget._isLoading ? LoadingButton() : Container(
            width: 40.0,
            height: 40.0,
            margin: EdgeInsets.only(
              right: 4.0,
            ),
            decoration: BoxDecoration(
              color: widget._isEnabled ? Theme.of(context).primaryColor : Colors.grey,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: IconButton(
              onPressed: !widget._isEnabled ? null : () {
                widget._executeOnCompleted(_controller.text);
                // _controller.clear();
                FocusScope.of(context).unfocus();   // closes the keyboard
              },
              iconSize:
                  22.0, //see this for correcting inkwell sizing https://flutteragency.com/remove-iconbutton-big-padding/
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
