import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/services/firebase_services.dart';
import 'package:weather_app/ui/screen/data_screen/data_screen_state.dart';

class DataWeatherWidgetCubit extends Cubit<DataScreenState> {
  final _firebaseServices = FirebaseServices();
  String dataValue = '';
  late final StreamSubscription<QuerySnapshot> weatherBlocSubscription;
  DataWeatherWidgetCubit(DataScreenState initialState) : super(initialState) {
    weatherBlocSubscription = listenFirebase().listen(_updateState);
  }

  Stream<QuerySnapshot> listenFirebase() {
    final streamListen =
        FirebaseFirestore.instance.collection('weather_item').snapshots();
    return streamListen;
  }

  Future<void> deleteDataWeather(
      int index, List<QueryDocumentSnapshot<Object?>>? dataList) async {
    _firebaseServices.deleteDataWeather(index, dataList);
  }

  void _updateState(QuerySnapshot snapshot) {
    final newState = state.copyWith(dataList: snapshot.docs);
    emit(newState);
  }

  String value(int index, String path) {
    return dataValue = state.dataList![index].get(path).toString();
  }
}
