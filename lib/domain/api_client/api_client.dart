import 'dart:convert';
import 'dart:io';
import 'package:weather_app/domain/configuration/configuration.dart';
import 'package:weather_app/domain/entity/weather.dart';

enum ApiClientExceptionTipe { network }

class ApiClientException implements Exception {
  final ApiClientExceptionTipe type;

  ApiClientException(this.type);
}

class ApiClient {
  final _client = HttpClient();

  Future<T> _get<T>(String lat, String lon, String apiKey,
      T Function(dynamic json) parser) async {
    try {
      final url = Uri.parse(
          '${Configuration.host}$lat$lon${Configuration.metric}$apiKey');
      final request = await _client.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      final result = parser(json);
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionTipe.network);
    }
  }

  Future<WeatherApi> weatherLoad(String lat, String lon) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = WeatherApi.fromJson(jsonMap);
      return response;
    }

    final result = _get(
      'lat=$lat',
      '&lon=$lon',
      '&appid=${Configuration.apiKey}',
      parser,
    );
    return result;
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then<dynamic>((v) => json.decode(v));
  }
}
