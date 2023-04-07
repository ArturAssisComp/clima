import 'package:flutter/material.dart';

const int kHttpSuccessful = 200;

const String kWeatherAPIAuthority = 'api.open-meteo.com';
const String kWeatherAPIPath = '/v1/forecast';
const Map<String, String> kWeatherAPIQueryParameters = {
  'hourly':
      'temperature_2m,relativehumidity_2m,apparent_temperature,precipitation_probability,precipitation,rain,visibility,windspeed_10m,soil_temperature_0cm',
};

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);
