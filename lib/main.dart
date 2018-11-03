import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/ui/nice_home_screen.dart';
import 'package:nice_animals_flutter/ui/nice_splash_screen.dart';

void main() => runApp(new MyApp());

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => NiceHomeScreen(),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nice Application',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: SplashScreenPage(title: 'Nice splash page'),
      routes: routes,
    );
  }
}
