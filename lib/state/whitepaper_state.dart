import 'package:aws_whitepapers_guides/constants/filters/business_categories.dart';
import 'package:aws_whitepapers_guides/constants/filters/content_types.dart';
import 'package:aws_whitepapers_guides/constants/filters/industries.dart';
import 'package:aws_whitepapers_guides/constants/filters/methodology.dart';
import 'package:aws_whitepapers_guides/constants/filters/technology_categories.dart';
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
      List<String> contentTypeFilters,
      List<String> methodologyFilters,
      List<String> industryFilters,
      List<String> technologyCategoryFilters,
      List<String> businessCategoryFilters) async {
    // Formulate Query URL
    //String queryUrl = '$_baseUrl${this._pageNumber}';
    // 1. With only one type filter applied |whitepapers is not used
    // 2. When multiple type filter is applied all filters have |GLOBAL appended at end except for the last one
    // e.g. https://aws.amazon.com/api/dirs/items/search?item.directoryId=whitepapers&sort_by=item.additionalFields.sortDate&sort_order=desc&size=15&item.locale=en_US&tags.id=whitepapers%23content-type%23whitepaper%7Cwhitepapers%23content-type%23tech-guide
    String queryUrl = '$_baseUrl&size=$_pageSize&page=$_pageNumber';

    if (contentTypeFilters.length > 0) {
      queryUrl = _appendQueryUrl(queryUrl, contentTypeFilters, 'content-type',
          ContentTypes.mapQueryString);
    }

    if (methodologyFilters.length > 0) {
      queryUrl = _appendQueryUrl(queryUrl, methodologyFilters, 'methodology',
          Methodology.mapQueryString);
    }

    // Technology Categories
    if (technologyCategoryFilters.length > 0) {
      queryUrl = _appendQueryUrl(queryUrl, technologyCategoryFilters,
          'tech-category', TechnologyCategories.mapQueryString);
    }

    if (industryFilters.length > 0) {
      queryUrl = _appendQueryUrl(
          queryUrl, industryFilters, 'industry', Industries.mapQueryString);
    }

    if (businessCategoryFilters.length > 0) {
      queryUrl = _appendQueryUrl(queryUrl, businessCategoryFilters,
          'business-category', BusinessCategories.mapQueryString);
    }
    // TODO: can't encode the url for some reason, encoding manually for now
    // call http service after queryUrl is formed

    print("query url: $queryUrl");
    _rootAwsResponse.add(HttpService.fetchData(queryUrl));

    notifyListeners();
  }

  String _appendQueryUrl(String baseUrl, List<String> filters, String param,
      Map<String, String> mapQueryString) {
    String queryUrl = '$baseUrl&tags.id=GLOBAL';

    for (int i = 0; i < filters.length; i++) {
      if (i == filters.length - 1) {
        queryUrl = '$queryUrl%23$param%23${mapQueryString[filters[i]]}';
      } else {
        queryUrl =
            '$queryUrl%23$param%23${mapQueryString[filters[i]]}%7CGLOBAL';
      }
    }

    return queryUrl;
  }
}
