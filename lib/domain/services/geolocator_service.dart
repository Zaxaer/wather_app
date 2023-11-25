import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Position> getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<bool> isLocationServiceEnabled() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    return serviceEnabled;
  }

  Future<bool> checkPermission() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
