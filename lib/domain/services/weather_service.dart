import 'package:weather_app/domain/api_client/api_client.dart';
import 'package:weather_app/domain/entity/weather.dart';

class WeatherService {
  final _apiClient = ApiClient();

  Future<WeatherApi?> loadWeather(String lat, String lon) async {
    final weatherData = await _apiClient.weatherLoad(lat, lon);
    return weatherData;
  }
}
