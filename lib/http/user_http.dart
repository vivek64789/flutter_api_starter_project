import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_api/model/user.dart';

class HttpConnectUser {
  static const String _baseUrl = "http://127.0.0.1:3000/api/v1/"; // localhost  = 127.0.0.1
  String token = '';
  //sending

  registerUser(User user, String? lname) async {
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
    http.Response? response;
    try {
      response = await http.post(
        Uri.parse(HttpConnectUser._baseUrl + url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
    } catch (err) {
      print(err);
    }
    return jsonDecode(response!.body);
  }
}
