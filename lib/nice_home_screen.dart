import 'package:flutter/material.dart';

class NiceHomeScreen extends StatefulWidget {
  @override
  _NiceHomeState createState() => new _NiceHomeState();
}

class _NiceHomeState extends State<NiceHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Nice Animals'),
        elevation: 0.7,
      ),
      body: Center(
        child: Text('Hello World'),
      ),
    );
  }
}
