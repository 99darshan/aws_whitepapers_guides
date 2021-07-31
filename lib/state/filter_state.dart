import 'package:aws_whitepapers_guides/constants/filters/filter_by.dart';
import 'package:flutter/widgets.dart';

class FilterState extends ChangeNotifier {
  List<String> _contentTypeFilters = [];
  List<String> _technologyCategoryFilters = [];
  List<String> _industryFilters = [];
  List<String> _businessCategoryFilters = [];
  List<String> _methodologyFilters = [];

  List<String> get contentTypeFilters => _contentTypeFilters;
  List<String> get methodologyFilters => _methodologyFilters;
  List<String> get technologyCategoryFilters => _technologyCategoryFilters;
  List<String> get industryFilters => _industryFilters;
  List<String> get businessCategoryFilters => _businessCategoryFilters;

  addFilter(String filter, FilterBy filterBy) {
    switch (filterBy) {
      case FilterBy.ContentTypes:
        _contentTypeFilters.add(filter);
        notifyListeners();
        break;
      case FilterBy.Methodology:
        _methodologyFilters.add(filter);
        notifyListeners();
        break;
      case FilterBy.Industries:
        _industryFilters.add(filter);
        notifyListeners();
        break;
      case FilterBy.TechnologyCategories:
        _technologyCategoryFilters.add(filter);
        notifyListeners();
        break;
      case FilterBy.BusinessCategories:
        _businessCategoryFilters.add(filter);
        notifyListeners();
        break;
      default:
        return;
    }
  }

  removeFilter(String filter, FilterBy filterBy) {
    switch (filterBy) {
      case FilterBy.ContentTypes:
        _contentTypeFilters.remove(filter);
        notifyListeners();
        break;
      case FilterBy.Methodology:
        _methodologyFilters.remove(filter);
        notifyListeners();
        break;
      case FilterBy.Industries:
        _industryFilters.remove(filter);
        notifyListeners();
        break;
      case FilterBy.TechnologyCategories:
        _technologyCategoryFilters.remove(filter);
        notifyListeners();
        break;
      case FilterBy.BusinessCategories:
        _businessCategoryFilters.remove(filter);
        notifyListeners();
        break;
      default:
        return;
    }
  }

  resetAllFilters() {
    this._contentTypeFilters.clear();
    this._methodologyFilters.clear();
    this._industryFilters.clear();
    this._technologyCategoryFilters.clear();
    this._businessCategoryFilters.clear();
  }
}
