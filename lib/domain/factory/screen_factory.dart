import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/blocs/weather_bloc.dart';
import 'package:weather_app/ui/screen/data_screen/data_screen_state.dart';
import 'package:weather_app/ui/screen/data_screen/data_screen_widget.dart';
import 'package:weather_app/ui/screen/data_screen/data_screen_widget_model.dart';
import 'package:weather_app/ui/screen/main_tap_screen/main_tab_screen_state.dart';
import 'package:weather_app/ui/screen/main_tap_screen/main_tab_screen_widget.dart';
import 'package:weather_app/ui/screen/main_tap_screen/main_tab_screen_widget_cubit.dart';
import 'package:weather_app/ui/screen/view_weather_screen/view_weather_screen_widget.dart';
import 'package:weather_app/ui/screen/view_weather_screen/view_weather_screen_widget_cubit.dart';

class ScreenFactory {
  Widget mainTabScreen() {
    return BlocProvider(
        create: (_) => MainTabScreenWidgetCubit(
              const MainTabScreenState.initialState(),
            ),
        child: const MainTabScreenWidget());
  }

  Widget mainWeatherScreenWidgetModel() {
    return BlocProvider(
        create: (_) => ViewWeatherScreenWidgetCubit(
              WeatherBloc(
                WeatherApiState(weatherData: null),
              ),
            ),
        child: const ViewWeatherScreenWidget());
  }

  Widget dataWeatherWidgetModel() {
    return BlocProvider(
        create: (_) =>
            DataWeatherWidgetCubit(const DataScreenState.initialState()),
        child: const DataWeatherWidget());
  }
}
