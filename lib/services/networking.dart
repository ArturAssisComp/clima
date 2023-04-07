import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Local constants:
//  Geopafy constants

//Create an environment variable with name GEOPAFY_API_KEY and value of your API
// key for geopary and add it as environment variable using the argument
// --dart-define=GEOPAFY_API_KEY=YOUR_API_KEY_VALUE for flutter run or flutter
// build
const String _kGeopafyAPIKey = String.fromEnvironment('GEOPAFY_API_KEY');
const String _kGeopafyAPIAuthority = 'api.geoapify.com';
const String _kGeopafyAPIPath = '/v1/geocode/reverse';
const Map<String, String> _kGeopafyAPIQueryBasicParameters = {
  'apiKey': _kGeopafyAPIKey,
};

//  Open meteo constants
const String _kOpenMeteoAPIAuthority = 'api.open-meteo.com';
const String _kOpenMeteoAPIPath = '/v1/forecast';
const Map<String, String> _kOpenMeteoAPIQueryBasicParameters = {
  'hourly':
      'temperature_2m,apparent_temperature,precipitation_probability,precipitation,rain,weathercode,visibility',
  'daily':
      'temperature_2m_max,temperature_2m_min,apparent_temperature_max,apparent_temperature_min,precipitation_sum,rain_sum,precipitation_hours,windspeed_10m_max',
  'forecast_days': '1',
  'timezone': 'auto',
};

Future<Map<String, String>> getWeatherData(
    {required double latitude, required double longitude}) async {
  Map<String, String> queryParameters = {
    'latitude': latitude.toStringAsFixed(2),
    'longitude': longitude.toStringAsFixed(2),
  };
  queryParameters.addAll(_kOpenMeteoAPIQueryBasicParameters);

  Uri uri = Uri.https(
    _kOpenMeteoAPIAuthority,
    _kOpenMeteoAPIPath,
    queryParameters,
  );
  http.Response response = await http.get(uri);
  if (response.statusCode == kHttpSuccessful) {
    String data = response.body;
    var jsonData = jsonDecode(data);
    String currentTemperature =
        '${jsonData['hourly']['temperature_2m'][TimeOfDay.now().hour]}';
    String temperatureUnit = '${jsonData['hourly_units']['temperature_2m']}';
    String weatherCode =
        '${jsonData['hourly']['weathercode'][TimeOfDay.now().hour]}';
    return <String, String>{
      'currentTemperature': currentTemperature,
      'temperatureUnit': temperatureUnit,
      'weatherCode': weatherCode,
    };
  } else {
    return <String, String>{};
  }
}

Future<Map<String, String>> getLocationData(
    {required double latitude, required double longitude}) async {
  Map<String, String> queryParameters = {
    'lat': latitude.toStringAsFixed(2),
    'lon': longitude.toStringAsFixed(2),
  };
  queryParameters.addAll(_kGeopafyAPIQueryBasicParameters);

  Uri uri = Uri.https(
    _kGeopafyAPIAuthority,
    _kGeopafyAPIPath,
    queryParameters,
  );
  http.Response response = await http.get(uri);
  if (response.statusCode == kHttpSuccessful) {
    String data = response.body;
    var jsonData = jsonDecode(data);
    String cityStateCountry =
        '${jsonData['features'][0]['properties']['city']}, ${jsonData['features'][0]['properties']['state']} (${jsonData['features'][0]['properties']['country']})';
    return <String, String>{
      'cityStateCountry': cityStateCountry,
    };
  } else {
    return <String, String>{};
  }
}
