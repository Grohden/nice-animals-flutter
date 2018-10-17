import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/util/nice_navigator.dart';

class SplashScreenPage extends StatefulWidget {
  SplashScreenPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenPageState createState() => new _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => NiceNavigator.goToHome(context));
  }

  @override
  Widget build(BuildContext context) {
    var loader = new CircularProgressIndicator(
      value: null,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
    );

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
        backgroundColor: Colors.amber,
        body: new Stack(
          children: <Widget>[
            new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Image.asset('assets/main_icon.png', width: 100.0),
                  new Text(
                    'Nice Animals',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  new Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    child: loader,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
