import 'dart:convert';
import 'dart:io';
import 'package:aws_whitepapers_guides/models/rootAwsResponse.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static Future<RootAwsResponse> fetchData(String queryUrl) async {
    try {
      print('query url is: ' + queryUrl);
      Uri uri = Uri.parse(queryUrl);
      final response = await http.get(uri);
      print('fetching data... ' + response.statusCode.toString());
      if (response.statusCode == 200) {
        return RootAwsResponse.fromJson(json.decode(response.body));
      } else {
        // TODO: Error Handling display Widget,
        // Not found status codes, interent not available and so on
        // handle zero results?? for certain filter combinations if no results are found?
        throw Exception('Error fetching data from AWS');
      }
    } on SocketException catch (_) {
      throw SocketException('No Active Internet Connection');
    } on Exception catch (_) {
      throw Exception("Error fetching data from AWS");
    }
  }
}
