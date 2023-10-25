import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiGetService {
  String endPoint;
  String baseUrl;
  BuildContext context;
  Map<String, String>? headers;

  ApiGetService({
    required this.context,
    required this.headers,
    required this.baseUrl,
    required this.endPoint,
  });

  Future<Map<String, dynamic>> sendRequest() async {
    try {
      var url = Uri.parse(baseUrl + endPoint);
      var response = await http.get(
        url,
        headers: headers,
      );

      var responseBody = json.decode(response.body);
      print(responseBody);

      return responseBody;
    } catch (e) {
      print('An error has occurred: $e');
      return {};
    }
  }
}
