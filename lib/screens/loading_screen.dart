import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late final Position _position;
  late final double? _longitude;
  late final double? _latitude;

  void printPosition() async {
    Location location = Location();
    await location.getCurrentLocation();
    _longitude = location.longitude;
    _latitude = location.latitude;
    print('Longitude: $_longitude, Latitude: $_latitude');
  }

  @override
  void initState() {
    super.initState();
    printPosition();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
