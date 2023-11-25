import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/api_client/api_client.dart';
import 'package:weather_app/domain/entity/weather.dart';
import 'package:weather_app/domain/services/firebase_services.dart';
import 'package:weather_app/domain/services/geolocator_service.dart';
import 'package:weather_app/ui/screen/view_weather_screen/view_weather_state.dart';

class WeatherApiState {
  WeatherApi? weatherData;
  String? error;
  WeatherApiState({
    this.weatherData,
    this.error,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherApiState && other.weatherData == weatherData;
  }

  @override
  int get hashCode => weatherData.hashCode;

  WeatherApiState copyWith({
    WeatherApi? weatherData,
    String? error,
  }) {
    return WeatherApiState(
      weatherData: weatherData ?? this.weatherData,
      error: error ?? this.error,
    );
  }
}

class WeatherBloc extends Cubit<WeatherApiState> {
  final _apiClient = ApiClient();
  final _geolocatorService = GeolocatorService();
  final _firebaseServices = FirebaseServices();

  WeatherBloc(WeatherApiState initialState) : super(initialState);

  Future<void> _loadWeather(String lat, String lon) async {
    try {
      final weatherData = await _apiClient.weatherLoad(lat, lon);
      final newState = state.copyWith(weatherData: weatherData);
      emit(newState);
    } catch (_) {
      final newState = state.copyWith(error: 'Ошибка соединения');
      emit(newState);
    }
  }

  Future<void> getPosition() async {
    final enable = await _geolocatorService.isLocationServiceEnabled();
    if (!enable) {
      final newState = state.copyWith(error: 'Службы геолокации отключены');
      emit(newState);
      return;
    }
    final permission = await _geolocatorService.checkPermission();
    if (!permission) {
      final newState =
          state.copyWith(error: 'Разрешения на местоположение запрещены');
      emit(newState);
      return;
    }
    final position = await _geolocatorService.getCurrentPosition();
    final lat = position.latitude.toString();
    final lon = position.longitude.toString();
    await _loadWeather(lat, lon);
  }

  Future<void> addDataWeather(WeatherCubitState weatherState) async {
    _firebaseServices.addDataWeather(weatherState);
  }
}
