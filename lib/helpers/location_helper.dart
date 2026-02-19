import 'package:geolocator/geolocator.dart';
import '../features/location/model/user_location_model.dart';

class LocationHelper {
  static Future<UserLocationModel> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return UserLocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
