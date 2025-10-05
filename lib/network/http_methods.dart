import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl = "https://jsonplaceholder.typicode.com";

class HttpMethods {
  HttpMethods();

  Future<dynamic> commonApiGet(
    String endPointUrl, {
    String additionalPathParam = '',
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/$endPointUrl/$additionalPathParam');
      print('------------------> GET ${uri.toString()}');

      // headers
      final headers = {
        'Accept': 'application/json',
        // 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        // 'Accept-Language': 'en-US,en;q=0.9',
        // 'Referer': baseUrl,
        // 'Connection': 'keep-alive',
        // 'Accept-Encoding': 'gzip, deflate, br',
      };

      final response = await http.get(uri, headers: headers);

      print('------------------> Get status: ${response.statusCode}');
      print('------------------> response.headers: ${response.headers}');
      
      if (response.statusCode != 200) {
        throw Exception(
          'Request to $uri failed with status ${response.statusCode}',
        );
      }
      return _handleResponse(response);
    } catch (e) {
      print('------------------> Error at commonGet $e');
      rethrow;
    }
  }

  dynamic _handleResponse(http.Response response) {
    try {
      final jsonResponse = jsonDecode(response.body);
      print(
        '------------------> jsonResponse at commonGet type=${jsonResponse.runtimeType}',
      );
      return jsonResponse;
    } catch (e) {
      print(
        '------------------> Failed to decode response body: ${response.body}',
      );
      throw Exception('Failed to decode response: $e');
    }
  }
}
