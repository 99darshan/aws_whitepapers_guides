import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/models/index.dart';
import 'package:aws_whitepapers_guides/models/rootAwsResponse.dart';
import 'package:aws_whitepapers_guides/services/http_service.dart';
import 'package:flutter/foundation.dart';

class WhitepaperState extends ChangeNotifier {
  static final WhitepaperState _singleton = WhitepaperState._();

  // creates a WhitepaperState object
  WhitepaperState._() {
    print('fetching from named _ constructor in whitepaper object');
    // NOTE: uncomment below if whitepapers info needs to be fetched when loading the app, now it is only loaded when an action occurs on homescreen
    //initFetchWhitepapers();
  }

  factory WhitepaperState() {
    return _singleton;
  }

  List<Future<RootAwsResponse>> _rootAwsResponse = [];
  List<Future<RootAwsResponse>> _searchAwsReponse = [];
  int _pageSize = 50;
  int _pageNumber = 0;
  bool _hasNextPage = true;
  static const _baseUrl =
      'https://aws.amazon.com/api/dirs/items/search?item.directoryId=whitepapers&sort_by=item.additionalFields.sortDate&sort_order=desc&item.locale=en_US';

  List<Future<RootAwsResponse>> get rootAwsResponse => _rootAwsResponse;
  List<Future<RootAwsResponse>> get searchAwsResponse => _searchAwsReponse;
  bool get hasNextPage => _hasNextPage;

  // NOTE: this function is redundent, fetchFiltersWhitepapers with blank filters as arguments can be called instead of this
  initFetchWhitepapers() async {
    String queryUrl = '$_baseUrl&size=$_pageSize&page=$_pageNumber';
    _rootAwsResponse.add(HttpService.fetchData(queryUrl));
    notifyListeners();
  }

  setPageNumber() {
    _pageNumber += 1;
  }

  resetWhitepaperState() {
    _rootAwsResponse = [];
    _searchAwsReponse = [];
    _hasNextPage = true;
    _pageNumber = 0;
  }

  fetchWhitepapersBySearchKeywords(String searchKeyword) {
    String queryUrl =
        '$_baseUrl&size=$_pageSize&page=$_pageNumber&q=$searchKeyword&q_operator=AND';
    _searchAwsReponse.add(HttpService.fetchData(queryUrl));
    notifyListeners();
  }

  updateHasNextPage(Metadata metadata) {
    if (metadata.count == 0) {
      this._hasNextPage = false;
    } else {
      this._hasNextPage =
          metadata.count + (_pageNumber * _pageSize) < metadata.totalHits;
    }
  }

  Future fetchFilteredWhitepapers(
      List<String> typeFiltersList,
      List<String> categoryFiltersList,
      List<String> industryFiltersList,
      List<String> productFiltersList) async {
    //String queryUrl = '$_baseUrl${this._pageNumber}';
    String queryUrl = '$_baseUrl&size=$_pageSize&page=$_pageNumber';

    if (typeFiltersList.length > 0) {
      // Query String example with type filters
      // 1. With only one type filter applied |whitepapers is not used
      // 2. When multiple type filter is applied all filters have |whitepapers appended at end except for the last one
      // e.g. https://aws.amazon.com/api/dirs/items/search?item.directoryId=whitepapers&sort_by=item.additionalFields.sortDate&sort_order=desc&size=15&item.locale=en_US&tags.id=whitepapers%23content-type%23whitepaper%7Cwhitepapers%23content-type%23tech-guide
      queryUrl = '$queryUrl&tags.id=GLOBAL';
      for (int i = 0; i < typeFiltersList.length; i++) {
        if (i == typeFiltersList.length - 1) {
          queryUrl =
              '$queryUrl%23content-type%23${TypesFilter.mapTypesFilterToQueryString[typeFiltersList[i]]}';
        } else {
          queryUrl =
              '$queryUrl%23content-type%23${TypesFilter.mapTypesFilterToQueryString[typeFiltersList[i]]}%7Cwhitepapers';
        }
      }
    }

    if (categoryFiltersList.length > 0) {
      queryUrl = '$queryUrl&tags.id=whitepapers';
      for (int i = 0; i < categoryFiltersList.length; i++) {
        if (i == categoryFiltersList.length - 1) {
          queryUrl =
              '$queryUrl%23content-category%23${CategoriesFilter.mapCategoriesFilterToQueryString[categoryFiltersList[i]]}';
        } else {
          queryUrl =
              '$queryUrl%23content-category%23${CategoriesFilter.mapCategoriesFilterToQueryString[categoryFiltersList[i]]}%7Cwhitepapers';
        }
      }
    }

    if (productFiltersList.length > 0) {
      queryUrl = '$queryUrl&tags.id=whitepapers';
      for (int i = 0; i < productFiltersList.length; i++) {
        if (i == productFiltersList.length - 1) {
          queryUrl =
              '$queryUrl%23categories%23${ProductsFilter.mapProductsFilterToQueryString[productFiltersList[i]]}';
        } else {
          queryUrl =
              '$queryUrl%23categories%23${ProductsFilter.mapProductsFilterToQueryString[productFiltersList[i]]}%7Cwhitepapers';
        }
      }
    }

    if (industryFiltersList.length > 0) {
      queryUrl = '$queryUrl&tags.id=whitepapers';
      for (int i = 0; i < industryFiltersList.length; i++) {
        if (i == industryFiltersList.length - 1) {
          queryUrl =
              '$queryUrl%23industry%23${IndustriesFilter.mapIndustriesFilterToQueryString[industryFiltersList[i]]}';
        } else {
          queryUrl =
              '$queryUrl%23content-category%23${IndustriesFilter.mapIndustriesFilterToQueryString[industryFiltersList[i]]}%7Cwhitepapers';
        }
      }
    }
    // TODO: can't encode the url for some reason, encoding manually for now
    // call http service after queryUrl is formed

    print("query url: $queryUrl");
    _rootAwsResponse.add(HttpService.fetchData(queryUrl));

    notifyListeners();
    //_rootAwsResponse = HttpService.fetchData(queryUrl);
    //notifyListeners();
    //setIsFetchingData(false);
  }
}
