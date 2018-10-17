import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/nice_home_screen.dart';
import 'package:nice_animals_flutter/nice_splash_screen.dart';

void main() => runApp(new MyApp());

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => NiceHomeScreen(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Nice Application',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: new SplashScreenPage(title: 'Flutter Demo Home Page'),
      routes: routes,
    );
  }
}
