import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/ui/util/nice_navigator.dart';
import 'package:nice_animals_flutter/ui/widgets/app_loader.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => NiceNavigator.goToHome(context));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Colors.amber,
        body: Stack(
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/main_icon.png', width: 100.0),
                  Text(
                    'Nice Animals',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    child: AppLoader(),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
