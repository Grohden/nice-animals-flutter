import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/main_icon.png', width: 100.0),
                Text(
                  'Nice Animals',
                  style: theme.textTheme.headline5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
