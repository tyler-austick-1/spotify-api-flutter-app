import 'package:flutter/material.dart';
import 'package:spotify_app/models/search_type.dart';

class SelectionBubble extends StatefulWidget {
  final SearchType searchType;
  final Function toggleSelection;
  final bool isdefaultSelected;
  final bool isEnabled;

  SelectionBubble(this.searchType, this.toggleSelection,
      [this.isdefaultSelected = false, this.isEnabled = true]);

  @override
  _SelectionBubbleState createState() => _SelectionBubbleState();
}

class _SelectionBubbleState extends State<SelectionBubble> {
  bool _isSelected;

  @override
  void initState() {
    _isSelected = widget.isdefaultSelected;
    super.initState();
  }

  void _updateSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
    widget.toggleSelection(widget.searchType);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled ?  _updateSelection : null,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 4.0,
        ),
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
          border: Border.all(
            color: !widget.isEnabled ? Colors.black38 : Colors.black54,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Text(
            widget.searchType.name,
            style: TextStyle(
              color: !widget.isEnabled ? Colors.grey : (_isSelected ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
