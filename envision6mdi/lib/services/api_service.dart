import 'dart:convert';
// import 'package:api_manager/api_manager.dart';
// import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';

class ApiService {
  Future get(String path) async {
    var url = Uri.parse(path);
    final response = await http.get(
      url,
      headers: getHeader(),
    );

    try {
      final body = json.decode(response.body);
      return body;
    } on FormatException {
      return response.body;
    }
  }

  Future post(String path, Object body) async {
    var url = Uri.parse(path);
    var client = http.Client();
    // var data = await compute(_bodyEncode, body);
    var response = await client.post(
      url,
      headers: getHeader(),
      body: json.encode(body),
    );
    try {
      return json.decode(response.body);
    } on FormatException {
      return response.body;
    }
  }

  Map<String, String> getHeader() {
    return {
      'Content-Type': 'application/json',
    };
  }
}
