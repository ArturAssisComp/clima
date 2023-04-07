import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/data.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required Map<String, String> arguments})
      : _initialArguments = arguments;

  final Map<String, String> _initialArguments;

  static const String routeName = '/location-screen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final WeatherModel weatherModel = WeatherModel();
  Map<String, String> _data = {};
  String _weatherText = '';
  String _weatherIcon = '';
  String _temperatureWithUnit = '';

  Future<void> updateWeatherWithCurrentLocation() async {
    Map<String, String> tmp =
        await DataManager.getLocationAndDataByCurrentCoordinates();
    if (tmp.isNotEmpty) {
      setState(() {
        _data = tmp;
        _updateStateVariables();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initDateFromLoadingPage();
  }

  void _updateStateVariables() {
    _weatherText =
        '${weatherModel.getMessage(double.parse(_data['currentTemperature']!).toInt())} in ${_data['cityStateCountry']}';
    _temperatureWithUnit =
        '${_data['currentTemperature']} ${_data['temperatureUnit']} ';
    _weatherIcon = weatherModel.getWeatherIcon(_data['weatherCode']!);
  }

  void initDateFromLoadingPage() {
    _data = widget._initialArguments;
    _updateStateVariables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      await updateWeatherWithCurrentLocation();
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      _temperatureWithUnit,
                      style: kTempTextStyle,
                    ),
                    Text(
                      _weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  _weatherText,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
