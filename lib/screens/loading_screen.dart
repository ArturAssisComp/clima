import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/networking.dart' as networking;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final Map<String, String> _arguments = {};

  void getLocationAndData() async {
    Location location = Location();
    await location.getCurrentLocation();
    Map<String, String> weatherData = await networking.getWeatherData(
        latitude: location.latitude!, longitude: location.longitude!);
    Map<String, String> locationData = await networking.getLocationData(
        latitude: location.latitude!, longitude: location.longitude!);
    _arguments.addAll(weatherData);
    _arguments.addAll(locationData);
    if (context.mounted) {
      Navigator.pushNamed(context, '/location-screen', arguments: _arguments);
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationAndData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinKitPouringHourGlassRefined(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
