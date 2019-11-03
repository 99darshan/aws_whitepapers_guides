import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:flutter/widgets.dart';

class FilterState extends ChangeNotifier {
  List<String> _typesFilterList = [];
  List<String> _categoriesFilterList = [];
  List<String> _productsFilterList = [];
  List<String> _industriesFilterList = [];

  List<String> get typesFilterList => _typesFilterList;
  List<String> get categoriesFilterList => _categoriesFilterList;
  List<String> get productsFilterList => _productsFilterList;
  List<String> get industriesFilterList => _industriesFilterList;

  addFilter(String filter, FilterBy filterBy) {
    switch (filterBy) {
      case FilterBy.Types:
        _typesFilterList.add(filter);
        notifyListeners();
        break;
      case FilterBy.Categories:
        _categoriesFilterList.add(filter);
        notifyListeners();
        break;
      case FilterBy.Industries:
        _industriesFilterList.add(filter);
        notifyListeners();
        break;
      case FilterBy.Products:
        _productsFilterList.add(filter);
        notifyListeners();
        break;
      default:
        return;
    }
  }

  removeFilter(String filter, FilterBy filterBy) {
    switch (filterBy) {
      case FilterBy.Types:
        _typesFilterList.remove(filter);
        notifyListeners();
        break;
      case FilterBy.Categories:
        _categoriesFilterList.remove(filter);
        notifyListeners();
        break;
      case FilterBy.Industries:
        _industriesFilterList.remove(filter);
        notifyListeners();
        break;
      case FilterBy.Products:
        _productsFilterList.remove(filter);
        notifyListeners();
        break;
      default:
        return;
    }
  }

  resetAllFilters() {
    this._typesFilterList.clear();
    this._categoriesFilterList.clear();
    this._industriesFilterList.clear();
    this._productsFilterList.clear();
  }
}
