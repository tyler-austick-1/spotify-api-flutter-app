import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A horizontal bar of toggle tabs with customisable colors and labels.
///
/// The provided list of labels are laid out as tabs in a horizontal manner. The states of the tabs
/// are handled internally and the index of the selected tab is updated via [onSelectionUpdated].
class SelectionBar extends StatefulWidget {
  /// TextStyle for the labels.
  final TextStyle labelTextStyle;

  /// Background border of the toggle bar.
  final BoxBorder backgroundBorder;

  /// Color of the selected tab.
  final Color selectedTabColor;

  /// Color of text in the selected tab. This will override [color] in [labelTextStyle].
  final Color selectedTextColor;

  /// Color of text in unselected tabs. If the tab is selected, text color will be overriden by [selectedTextColor].
  final Color textColor;

  /// Labels to be displayed as tabs in the toggle bar.
  final List<String> labels;

  /// Callback function which returns the index of the currently selected tab.
  final Function(int) onSelectionUpdated;

  /// Border radius of the bar and selected tab indicator.
  final double borderRadius;

  SelectionBar(
      {@required this.labels,
      this.backgroundBorder,
      this.selectedTabColor = Colors.blue,
      this.selectedTextColor = Colors.white,
      this.textColor = Colors.white,
      this.labelTextStyle = const TextStyle(),
      this.onSelectionUpdated,
      this.borderRadius = 50});

  @override
  State<StatefulWidget> createState() {
    return _SelectionBarState();
  }
}

class _SelectionBarState extends State<SelectionBar> {
  LinkedHashMap<String, bool> _hashMap = LinkedHashMap();
  int _selectedIndex = 0;

  @override
  void initState() {
    _hashMap = LinkedHashMap.fromIterable(widget.labels,
        value: (value) => value = false);
    _hashMap[widget.labels[0]] = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
          height: 50,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: widget.backgroundBorder,
              borderRadius: BorderRadius.circular(widget.borderRadius)),
          child: ListView.builder(
            itemCount: widget.labels.length,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      width: (constraints.maxWidth - 35) / widget.labels.length,
                      child: Center(
                        child: Text(_hashMap.keys.elementAt(index),
                            textAlign: TextAlign.center,
                            style: widget.labelTextStyle.apply(
                                color: _hashMap.values.elementAt(index)
                                    ? widget.selectedTextColor
                                    : widget.textColor)),
                      ),
                      decoration: BoxDecoration(
                          color: _hashMap.values.elementAt(index)
                              ? widget.selectedTabColor
                              : null,
                          border: _hashMap.values.elementAt(index)
                              ? null
                              : Border.all(
                                  width: 1,
                                  color: Colors.black26,
                                ),
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius))),
                  onHorizontalDragUpdate: (dragUpdate) async {
                    int calculatedIndex = ((widget.labels.length *
                                    (dragUpdate.globalPosition.dx /
                                        (constraints.maxWidth - 16)))
                                .round() -
                            1)
                        .clamp(0, widget.labels.length - 1);

                    if (calculatedIndex != _selectedIndex) {
                      _updateSelection(calculatedIndex);
                    }
                  },
                  onTap: () async {
                    if (index != _selectedIndex) {
                      _updateSelection(index);
                    }
                  });
            },
          ));
    });
  }

  _updateSelection(int index) {
    setState(() {
      _selectedIndex = index;
      widget.onSelectionUpdated(_selectedIndex);
      _hashMap.updateAll((label, selected) => selected = false);
      _hashMap[_hashMap.keys.elementAt(index)] = true;
    });
  }
}
