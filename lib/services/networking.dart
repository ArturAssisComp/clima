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
const Map<String, String> _kOpenMeteoCodeConditionDescription = {
  '0': 'Clear sky',
  '1': 'Mainly clear',
  '2': 'Partly cloudy',
  '3': 'Overcast',
  '45': 'Fog',
  '48': 'Depositing rime fog',
  '51': 'Drizzle: Light intensity',
  '53': 'Drizzle: Moderate intensity',
  '55': 'Drizzle: Dense intensity',
  '56': 'Freezing Drizzle: Light intensity',
  '57': 'Freezing Drizzle: Dense intensity',
  '61': 'Rain: Slight intensity',
  '63': 'Rain: Moderate intensity',
  '65': 'Rain: Heavy intensity',
  '66': 'Freezing Rain: Light intensity',
  '67': 'Freezing Rain: Heavy intensity',
  '71': 'Snow fall: Slight intensity',
  '73': 'Snow fall: Moderate intensity',
  '75': 'Snow fall: Heavy intensity',
  '77': 'Snow grains',
  '80': 'Rain showers: Slight intensity',
  '81': 'Rain showers: Moderate intensity',
  '82': 'Rain showers: Violent intensity',
  '85': 'Snow showers slight intensity',
  '86': 'Snow showers heavy intensity',
  '95': 'Thunderstorm: Slight or moderate intensity',
  '96': 'Thunderstorm with slight hail',
  '99': 'Thunderstorm with heavy hail',
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
      'weatherDescription': _kOpenMeteoCodeConditionDescription[weatherCode] ??
          'Unknown weather-code.',
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
