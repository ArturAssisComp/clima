import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late final double? _longitude;
  late final double? _latitude;

  void getLocationAndData() async {
    Location location = Location();
    await location.getCurrentLocation();
    _longitude = location.longitude;
    _latitude = location.latitude;
    print('Longitude: $_longitude, Latitude: $_latitude');

    Map<String, String> queryParameters = {
      'latitude': _latitude?.toStringAsFixed(2) ?? '0.0',
      'longitude': _longitude?.toStringAsFixed(2) ?? '0.0'
    };
    queryParameters.addAll(kWeatherAPIQueryParameters);

    Uri uri = Uri.https(
      kWeatherAPIAuthority,
      kWeatherAPIPath,
      queryParameters,
    );
    http.Response response = await http.get(uri);
    if (response.statusCode == kHttpSuccessful) {
      String data = response.body;
      print(response.body);
      print(uri);
      var jsonData = jsonDecode(data);
      String currentTemperature =
          '${jsonData['hourly']['temperature_2m'][TimeOfDay.now().hour]} ${jsonData['hourly_units']['temperature_2m']}';
      String timezone = '${jsonData['timezone']}';
      String weatherCode =
          '${jsonData['hourly']['weathercode'][TimeOfDay.now().hour]}';
      print('Temperature: $currentTemperature');
      print('Timezone: $timezone');
      print(
          'Weather Condition: ${kWeatherCodeConditionDescription[weatherCode]}');
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationAndData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
