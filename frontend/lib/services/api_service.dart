import 'dart:convert';
import 'package:frontend/models/login_request_model.dart';
import 'package:frontend/services/booking_service.dart';
import '../config.dart';
import 'package:http/http.dart' as http;

import '../models/login_response_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';

class APIService {
  static var client = http.Client();


 static Future<int> login1(String username, String password) async {
    var url = Uri.http(Config.apiURL, Config.loginAPI);
    var response = await http.post(url, body: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      var user = json.decode(response.body);
      int userId = user['id'];
      return userId;
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson())
    );
    if (response.statusCode == 200) {
      print("___________________________________________________________________________ true");
      await BookedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      print("___________________________________________________________________________    false");
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson())
    );
    return registerResponseModel(response.body);
  }
}