import 'dart:convert';

import 'package:aws_whitepapers_guides/constants/filter_constants.dart';
import 'package:aws_whitepapers_guides/models/rootAwsResponse.dart';
import 'package:http/http.dart' as http;

class AwsService {
  static Future<RootAwsResponse> fetchWhitepapers(
      List<String> typesFilter) async {
    // final whitepapersUrl =
    //     "https://aws.amazon.com/api/dirs/items/search?item.directoryId=whitepapers&sort_by=item.additionalFields.sortDate&sort_order=desc&size=15&item.locale=en_US&page=17";

    // TODO: page number?? paginated results and size
    final baseUrl =
        'https://aws.amazon.com/api/dirs/items/search?item.directoryId=whitepapers&sort_by=item.additionalFields.sortDate&sort_order=desc&size=100&item.locale=en_US&page=0';

    String queryUrl = baseUrl;

    if (typesFilter.length > 0) {
      queryUrl += '$baseUrl&tags.id=whitepapers';
      for (int i = 0; i < typesFilter.length; i++) {
        if (i == typesFilter.length - 1) {
          queryUrl +=
              '$queryUrl content-type ${TypesFilter.mapTypesFilterToQueryString[typesFilter[i]]}';
        } else {
          queryUrl +=
              '$queryUrl content-type ${TypesFilter.mapTypesFilterToQueryString[typesFilter[i]]}|whitepapers';
        }
      }
    }

    print('query url is: ' + queryUrl);
    final response = await http.get(queryUrl);
    print('fetching data... ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      return RootAwsResponse.fromJson(json.decode(response.body));
    } else {
      // TODO: Error Handling display Widget,
      // Not found status codes, interent not available and so on
      // handle zero results?? for certain filter combinations if no results are found?
      throw Exception('Error fetching data from AWS');
    }
  }
}
