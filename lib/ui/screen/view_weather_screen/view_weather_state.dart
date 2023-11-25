class WeatherCubitState {
  bool isLoading;
  String sityName;
  String temp;
  String icon;
  String windSpeed;
  String humidity;
  String data;
  String errorMessage;
  String snackMessage;
  WeatherCubitState({
    required this.isLoading,
    required this.sityName,
    required this.temp,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
    required this.data,
    required this.errorMessage,
    required this.snackMessage,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherCubitState &&
        other.isLoading == isLoading &&
        other.sityName == sityName &&
        other.temp == temp &&
        other.icon == icon &&
        other.windSpeed == windSpeed &&
        other.humidity == humidity &&
        other.data == data &&
        other.errorMessage == errorMessage &&
        other.snackMessage == snackMessage;
  }

  @override
  int get hashCode {
    return isLoading.hashCode ^
        sityName.hashCode ^
        temp.hashCode ^
        icon.hashCode ^
        windSpeed.hashCode ^
        humidity.hashCode ^
        data.hashCode ^
        errorMessage.hashCode ^
        snackMessage.hashCode;
  }

  WeatherCubitState copyWith({
    bool? isLoading,
    String? sityName,
    String? temp,
    String? icon,
    String? windSpeed,
    String? humidity,
    String? data,
    String? errorMessage,
    String? snackMessage,
  }) {
    return WeatherCubitState(
      isLoading: isLoading ?? this.isLoading,
      sityName: sityName ?? this.sityName,
      temp: temp ?? this.temp,
      icon: icon ?? this.icon,
      windSpeed: windSpeed ?? this.windSpeed,
      humidity: humidity ?? this.humidity,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      snackMessage: snackMessage ?? this.snackMessage,
    );
  }
}
