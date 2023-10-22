import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiPostService {
  String endPoint;
  String baseUrl;
  dynamic body;
  BuildContext context;
  Map<String, String>? headers;

  ApiPostService(
      {required this.context,
      required this.headers,
      required this.baseUrl,
      required this.endPoint,
      this.body});

  Future<Map<String, dynamic>> sendRequest() async {
    try {
      var url = Uri.parse(baseUrl + endPoint);
      var response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
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
