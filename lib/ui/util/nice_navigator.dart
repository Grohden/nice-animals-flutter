import 'package:flutter/material.dart';

class NiceNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }
}
