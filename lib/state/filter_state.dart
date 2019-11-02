import 'package:flutter/widgets.dart';

class FilterState extends ChangeNotifier {
  List<String> _typesFilterList = [];

  List<String> get typesFilterList => _typesFilterList;

  addTypesFilter(String filter) {
    _typesFilterList.add(filter);
    notifyListeners();
  }

  removeTypesFilter(String filter) {
    _typesFilterList.remove(filter);
    notifyListeners();
  }
}
