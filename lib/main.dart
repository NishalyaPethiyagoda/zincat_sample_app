import 'package:flutter/material.dart';
import 'package:zincat_sample_app/navigation/global_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GlobalNavigator(),
      debugShowCheckedModeBanner: false,
    );
  }
}
