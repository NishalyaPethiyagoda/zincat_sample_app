import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl = "https://jsonplaceholder.typicode.com";

class HttpMethods {
  HttpMethods();

  Future<dynamic> commonApiGet(String endPointUrl , { String additionalPathParam = ''}) async{

    try{
      final response = await http.get(Uri.parse('$baseUrl/$endPointUrl/$additionalPathParam') );
      return _handleResponse(response);
    }
    catch(e){
      print('------------------> error at commonGet $e');
      rethrow;
    }
  }

  dynamic _handleResponse(http.Response response){
    final jsonResponse = jsonDecode(response.body);
    print('------------------> jsonResponse at commonGet $jsonResponse');
    return jsonResponse;
  }
}