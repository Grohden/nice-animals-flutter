import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/ui/screen/home_screen.dart';
import 'package:shibe_api/services/shibe_api_service.dart';

final shibeApiService = ShibeApiService();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nice Animals',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
