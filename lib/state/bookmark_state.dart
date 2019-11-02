import 'dart:convert';
import 'package:aws_whitepapers_guides/models/whitepaperData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkState extends ChangeNotifier {
  static final BookmarkState _singleton = BookmarkState._();
  SharedPreferences _prefs;
  Set<String> _bookmarks;
  Set<String> get bookmarks => _bookmarks;

  // named constructor, creates a BookmarkState and calls the getAllBookmarks function which populates the _bookmarks field
  BookmarkState._() {
    getSharedPrefInstance();
    getAllBookmarks();
  }

  factory BookmarkState() {
    return _singleton;
    //return BookmarkState._();
  }

  getSharedPrefInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  getAllBookmarks() async {
    // Note: the field _prefs which exposes the instance of sharedPreference is not used here because this method and the getSharedPrefInstance which sets the _prefs are called from named constructor and _pref still be null by the time it is being accessed here, so this functions gets the instance of sharedpreferences on its own
    final prefs = await SharedPreferences.getInstance();
    _bookmarks = prefs.getKeys();
    notifyListeners();
  }

  addBookmark(String key, String payload) async {
    //final prefs = await SharedPreferences.getInstance();
    bool isAdded = await _prefs.setString(key, payload);
    if (isAdded) {
      _bookmarks.add(key);
      notifyListeners();
    }
  }

  removeBookmark(String key) async {
    //final prefs = await SharedPreferences.getInstance();
    bool isRemoved = await _prefs.remove(key);
    if (isRemoved) {
      _bookmarks.remove(key);
      notifyListeners();
    }
  }

  WhitepaperData getBookmarkedItem(String key) {
    //final prefs = await SharedPreferences.getInstance();
    final data = _prefs.getString(key);
    return WhitepaperData.fromJson(json.decode(data));
  }
}
