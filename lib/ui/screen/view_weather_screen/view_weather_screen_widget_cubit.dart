import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/blocs/weather_bloc.dart';
import 'package:weather_app/domain/configuration/configuration.dart';
import 'package:weather_app/ui/screen/view_weather_screen/view_weather_state.dart';

class ViewWeatherScreenWidgetCubit extends Cubit<WeatherCubitState> {
  final WeatherBloc weatherBloc;
  late final StreamSubscription<WeatherApiState> weatherBlocSubscription;
  ViewWeatherScreenWidgetCubit(
    this.weatherBloc,
  ) : super(
          WeatherCubitState(
            data: '',
            errorMessage: '',
            humidity: '',
            icon: '',
            isLoading: true,
            sityName: '',
            snackMessage: '',
            temp: '',
            windSpeed: '',
          ),
        ) {
    weatherBloc.getPosition();
    _onState(weatherBloc.state);
    weatherBlocSubscription = weatherBloc.stream.listen(_onState);
  }

  String _stringFromDate() {
    final dateFormat = DateFormat('', 'ru').add_yMd();
    final date = dateFormat.format(DateTime.now());
    return date;
  }

  void _onState(WeatherApiState state) {
    if (state.weatherData == null) {
      if (state.error != '') {
        final errorState = this.state.copyWith(errorMessage: state.error);
        emit(errorState);
        return;
      }
    }
    final newState = _makeStateData(state);
    emit(newState);
  }

  Future<void> addDataWeather() async {
    if (state.temp == '') return;
    weatherBloc.addDataWeather(state);
    final newState = state.copyWith(snackMessage: 'Данные добавлены');
    emit(newState);
  }

  WeatherCubitState _makeStateData(WeatherApiState weather) {
    return WeatherCubitState(
      data: _stringFromDate(),
      errorMessage: weather.error ?? '',
      humidity: "${weather.weatherData?.main.humidity.toString()} %",
      icon:
          '${Configuration.hostWeatherIcon}${weather.weatherData?.weather.first.icon}@2x.png',
      isLoading: false,
      sityName: weather.weatherData?.name ?? '',
      snackMessage: '',
      temp: "${weather.weatherData?.main.temp.toInt().toString()} \u00b0",
      windSpeed: "${weather.weatherData?.wind.speed.toString()} м/с",
    );
  }
}
