import 'package:aws_whitepapers_guides/bloc/filter_bloc.dart';
import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterChipWidget extends StatefulWidget {
  final String labelText;
  final FilterBy filterBy;
  List<String> types;
  // TODO: make filterby required
  FilterChipWidget(
      {Key key, @required this.labelText, this.filterBy, this.types})
      : super(key: key);

  @override
  FilterChipWidgetState createState() => FilterChipWidgetState();
}

class FilterChipWidgetState extends State<FilterChipWidget> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    final FilterBloc filterBloc = Provider.of<FilterBloc>(context);
    if (widget.filterBy == FilterBy.Types &&
        filterBloc.typesFilterList.contains(widget.labelText)) {
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
        if (isSelected && widget.filterBy == FilterBy.Types) {
          filterBloc.addTypesFilter(widget.labelText);
        }
        if (!isSelected && widget.filterBy == FilterBy.Types) {
          filterBloc.removeTypesFilter(widget.labelText);
        }
        // TODO: make function?? or just a map??
      },
    );
  }
}
