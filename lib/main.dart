import 'package:flutter/material.dart';
import 'package:gps_tracker/location/presentation/views/gps_tracker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GpsTrackerView(),
    );
  }
}
