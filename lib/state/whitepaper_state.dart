import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/models/rootAwsResponse.dart';
import 'package:aws_whitepapers_guides/services/http_service.dart';
import 'package:flutter/foundation.dart';

class WhitepaperState extends ChangeNotifier {
  static final WhitepaperState _singleton = WhitepaperState._();

  // creates a WhitepaperState object and fetches the initial whitepapers while doing so
  WhitepaperState._() {
    print('fetching from named _ constructor in whitepaper object');
    //fetchWhitepapers(List<String>());
    initFetchWhitepapers();
  }

  factory WhitepaperState() {
    return _singleton;
    //return WhitepaperState._();
  }

  RootAwsResponse _rootAwsResponse;
  bool _isFetchingData = false;
  // TODO: page number?? paginated results and size

  static const _baseUrl =
      'https://aws.amazon.com/api/dirs/items/search?item.directoryId=whitepapers&sort_by=item.additionalFields.sortDate&sort_order=desc&size=100&item.locale=en_US&page=0';

  RootAwsResponse get rootAwsResponse => _rootAwsResponse;
  bool get isFetchingData => _isFetchingData;

  void setIsFetchingData(bool newValue) {
    _isFetchingData = newValue;
    notifyListeners();
  }

  Future initFetchWhitepapers() async {
    setIsFetchingData(true);
    _rootAwsResponse = await HttpService.fetchData(_baseUrl);
    setIsFetchingData(false);
  }

  Future fetchFilteredWhitepapers(
      List<String> typeFiltersList,
      List<String> categoryFiltersList,
      List<String> industryFiltersList,
      List<String> productFiltersList) async {
    setIsFetchingData(true);
    String queryUrl = _baseUrl;

    if (typeFiltersList.length > 0) {
      // Query String example with type filters
      // 1. With only one type filter applied |whitepapers is not used
      // 2. When multiple type filter is applied all filters have |whitepapers appended at end except for the last one
      // e.g. https://aws.amazon.com/api/dirs/items/search?item.directoryId=whitepapers&sort_by=item.additionalFields.sortDate&sort_order=desc&size=15&item.locale=en_US&tags.id=whitepapers%23content-type%23whitepaper%7Cwhitepapers%23content-type%23tech-guide
      queryUrl = '$_baseUrl&tags.id=whitepapers';
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
    // TODO: do the same for other filters
    // TODO: can't encode the url for some reason, encoding manually for now
    // call http service after queryUrl is formed
    _rootAwsResponse = await HttpService.fetchData(queryUrl);
    //notifyListeners();
    setIsFetchingData(false);
  }
}
