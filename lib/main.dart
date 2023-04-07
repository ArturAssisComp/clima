import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      routes: <String, Widget Function(BuildContext)>{
        '/': (context) => const LoadingScreen(),
        '/location-screen': (context) => LocationScreen(),
      },
    );
  }
}
