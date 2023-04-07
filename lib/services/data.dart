import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart' as networking;

class DataManager {
  static Future<Map<String, String>>
      getLocationAndDataByCurrentCoordinates() async {
    final Map<String, String> result = {};
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, String> weatherData = await networking.getWeatherData(
        latitude: location.latitude!, longitude: location.longitude!);
    Map<String, String> locationData = await networking.getLocationData(
        latitude: location.latitude!, longitude: location.longitude!);
    result.addAll(weatherData);
    result.addAll(locationData);
    return result;
  }
}
