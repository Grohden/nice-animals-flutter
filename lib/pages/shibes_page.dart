import 'package:flutter/material.dart';

class ShibeScreen extends StatefulWidget {
  @override
  _ShibeScreenState createState() => new _ShibeScreenState();
}

class _ShibeScreenState extends State<ShibeScreen> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(100, (index) {
        return new Container(
          padding: EdgeInsets.all(5.0),
          child: Image.network(
            'https://cdn.shibe.online/shibes/4849b5f682721ce7a0b39cc57885c157219f2569.jpg',
            fit: BoxFit.cover,
          ),
        );
      }),
    );
  }
}
