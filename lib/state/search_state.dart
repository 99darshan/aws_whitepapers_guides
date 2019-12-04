import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchState extends ChangeNotifier {
  static final SearchState _singleton = SearchState._();
  SharedPreferences _prefs;
  List<String> _recentSearches = [];
  List<String> get recentSearches => _recentSearches;

  SearchState._() {
    getSharedPrefInstance();
    getAllRecentSearches();
    notifyListeners();
  }

  factory SearchState() {
    return _singleton;
  }

  updateRecentSearches(String searchTerm) {
    if (!_recentSearches.contains(searchTerm)) {
      if (_recentSearches.length > 10) _recentSearches.removeAt(0);
      _recentSearches.add(searchTerm);
      _prefs.setStringList("RECENT_WHITEPAPERS_SEARCHES", _recentSearches);
    }
    notifyListeners();
  }

  deleteAllRecentSearches() async {
    _prefs.remove("RECENT_WHITEPAPERS_SEARHES");
    _recentSearches.removeRange(0, _recentSearches.length);
    notifyListeners();
  }

  getSharedPrefInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  getAllRecentSearches() async {
    // Note: the field _prefs which exposes the instance of sharedPreference is not used here because this method and the getSharedPrefInstance which sets the _prefs are called from named constructor and _pref still be null by the time it is being accessed here, so this functions gets the instance of sharedpreferences on its own
    final prefs = await SharedPreferences.getInstance();
    _recentSearches = prefs.getStringList("RECENT_WHITEPAPERS_SEARCHES");
    // if no recent searches are saved, the key doesn't exists and _recentSearches will be null, set it to empty array
    if (_recentSearches == null) _recentSearches = [];
    notifyListeners();
  }
}
