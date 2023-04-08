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
    Map<String, String> locationData =
        await networking.getCityFromCoordinatesData(
            latitude: location.latitude!, longitude: location.longitude!);
    result.addAll(weatherData);
    result.addAll(locationData);
    return result;
  }

  static Future<Map<String, String>> getLocationAndDataByCityName(
      {required String cityName}) async {
    final Map<String, String> result = {};
    Map<String, String> location =
        await networking.getCoordinatesFromCityData(cityName: cityName);

    if (location.isEmpty) return result;

    Map<String, String> weatherData = await networking.getWeatherData(
        latitude: double.parse(location['latitude']!),
        longitude: double.parse(location['longitude']!));
    Map<String, String> locationData =
        await networking.getCityFromCoordinatesData(
            latitude: double.parse(location['latitude']!),
            longitude: double.parse(location['longitude']!));
    result.addAll(weatherData);
    result.addAll(locationData);
    return result;
  }
}
