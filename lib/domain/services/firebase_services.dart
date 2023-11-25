import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/ui/screen/view_weather_screen/view_weather_state.dart';

class FirebaseServices {
  Future<void> addDataWeather(WeatherCubitState weatherState) async {
    final dateFormat = DateFormat('', 'ru').add_yMd().add_Hms();
    final dateNow = dateFormat.format(DateTime.now());
    final addbase = FirebaseFirestore.instance.collection('weather_item');
    addbase.add(<String, dynamic>{
      'temp': weatherState.temp,
      'speed': weatherState.windSpeed,
      'humidity': weatherState.humidity,
      'data': dateNow,
    });
  }

  Future<void> deleteDataWeather(
      int index, List<QueryDocumentSnapshot<Object?>>? dataList) async {
    FirebaseFirestore.instance
        .collection('weather_item')
        .doc(dataList![index].id)
        .delete();
  }
}
