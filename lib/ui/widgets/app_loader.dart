import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
        value: null, valueColor: AlwaysStoppedAnimation<Color>(Colors.black54));
  }
}
