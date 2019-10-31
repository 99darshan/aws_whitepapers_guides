import 'dart:convert';
import 'package:aws_whitepapers_guides/models/rootAwsResponse.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static Future<RootAwsResponse> fetchData(String queryUrl) async {
    try {
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
    } catch (Exception) {
      print('Unknown error occured during fetching data from AWS...');
      return null; // TODO:handle this error in a better way
    }
  }
}
