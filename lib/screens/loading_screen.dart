import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/data.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  static const routeName = '/';

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final Map<String, String> _arguments = {};

  void getLocationAndData() async {
    _arguments.addAll(
      await DataManager.getLocationAndDataByCurrentCoordinates(),
    );
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
