import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app_with_clean_architecture/data/core/error/exception.dart';
import 'api_constants.dart';

///https://api.weatherapi.com/v1/forecast.json?key=dc2f0209b33642cbb72154206232505&q=London&days=3&aqi=no&alerts=no

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path, {Map<dynamic, dynamic>? params}) async {
    final response = await _client.get(
      Uri.parse(getPath(path, params)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 405) {
      throw ContentNotFoundException();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  String getPath(String path, Map<dynamic, dynamic>? params) {
    var paramsString = '';

    if (params?.isNotEmpty ?? false) {
      params!.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }
    return '${ApiConstants.BASE_URL}$path?key=${ApiConstants.API_KEY}$paramsString';
  }
}
