import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_api/model/user.dart';

class HttpConnectUser {
  static const String _baseUrl = "http://127.0.0.1:3000/api/v1/";
  //sending

  registerUser(User user) async {
    Map<String, dynamic> userMap = {
      "fname": user.fname,
      "lname": user.lname,
      "username": user.username,
      "password": user.password,
    };
    final response = await HttpConnect.post('auth/register', userMap);
    return response;
  }
}

// post data to server
class HttpConnect {
  static Future<Map<String, dynamic>> post(
      String url, Map<String, dynamic> body) async {
    final http.Response response = await http.post(
      Uri.parse(HttpConnectUser._baseUrl + url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );
    return jsonDecode(response.body);
  }
}
