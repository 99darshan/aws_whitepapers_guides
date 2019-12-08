import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/state/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterChipWidget extends StatefulWidget {
  final String labelText;
  final FilterBy filterBy;

  FilterChipWidget({Key key, @required this.labelText, @required this.filterBy})
      : super(key: key);

  @override
  FilterChipWidgetState createState() => FilterChipWidgetState();
}

class FilterChipWidgetState extends State<FilterChipWidget> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    final FilterState filterState = Provider.of<FilterState>(context);
    if ((widget.filterBy == FilterBy.Types &&
            filterState.typesFilterList.contains(widget.labelText)) ||
        (widget.filterBy == FilterBy.Categories &&
            filterState.categoriesFilterList.contains(widget.labelText)) ||
        (widget.filterBy == FilterBy.Industries &&
            filterState.industriesFilterList.contains(widget.labelText)) ||
        (widget.filterBy == FilterBy.Products &&
            filterState.productsFilterList.contains(widget.labelText))) {
      setState(() {
        _isSelected = true;
      });
    }
    return FilterChip(
      label: Text(widget.labelText),
      labelStyle: TextStyle(color: Colors.black87),
      //selectedShadowColor: Colors.teal[200],
      selectedColor: Theme.of(context).primaryColorLight,
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
