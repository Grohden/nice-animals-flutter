import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:niceanimals/ui/screen/home_screen.dart';
import 'package:niceanimals/ui/screen/splash_screen.dart';
import 'package:shibe_api/services/shibe_api_service.dart';

void main() {
  Get.put(ShibeApiService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
