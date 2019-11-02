import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterChipWidget extends StatefulWidget {
  final String labelText;
  final FilterBy filterBy;
  //List<String> types;
  // TODO: make filterby required
  FilterChipWidget({Key key, @required this.labelText, this.filterBy})
      : super(key: key);

  @override
  FilterChipWidgetState createState() => FilterChipWidgetState();
}

class FilterChipWidgetState extends State<FilterChipWidget> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    final FilterState filterState = Provider.of<FilterState>(context);
    if (widget.filterBy == FilterBy.Types &&
        filterState.typesFilterList.contains(widget.labelText)) {
      setState(() {
        _isSelected = true;
      });
    }
    return FilterChip(
      label: Text(widget.labelText),
      labelStyle: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
      selectedShadowColor: Colors.teal[200],
      selectedColor: Colors.teal[200],
      selected: _isSelected,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
        if (isSelected) {
          filterState.addFilter(widget.labelText, widget.filterBy);
        }
        if (!isSelected) {
          filterState.removeFilter(widget.labelText, widget.filterBy);
        }
        // TODO: make function?? or just a map??
      },
    );
  }
}
