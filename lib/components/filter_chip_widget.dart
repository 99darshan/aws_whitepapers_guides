import 'package:aws_whitepapers_guides/constants/filters/filter_by.dart';
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
    if (_allFilters(filterState).contains(widget.labelText)) {
      setState(() {
        _isSelected = true;
      });
    }

    return FilterChip(
      //backgroundColor: Theme.of(context).primaryColorLight,
      label: Text(widget.labelText),
      labelStyle:
          Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 12.0),
      //selectedShadowColor: Colors.teal[200],
      selectedColor: Theme.of(context).accentColor.withOpacity(0.4),
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
      },
    );
  }

  List<String> _allFilters(FilterState filterState) {
    switch (widget.filterBy) {
      case FilterBy.ContentTypes:
        return filterState.contentTypeFilters;
        break;
      case FilterBy.Methodology:
        return filterState.methodologyFilters;
        break;
      case FilterBy.TechnologyCategories:
        return filterState.technologyCategoryFilters;
        break;
      case FilterBy.Industries:
        return filterState.industryFilters;
        break;
      case FilterBy.BusinessCategories:
        return filterState.businessCategoryFilters;
        break;
      default:
        return [];
        break;
    }
  }
}
