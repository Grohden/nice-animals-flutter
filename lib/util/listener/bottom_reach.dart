import 'package:flutter/material.dart';

class OnBottomReach {
  OnBottomReach(ScrollController container, VoidCallback callback,
      {sensitivity: 200.0}) {
    container.addListener(() {
      var maxScroll = container.position.maxScrollExtent;
      var currentScroll = container.position.pixels;
      if (maxScroll - currentScroll <= sensitivity) {
        callback();
      }
    });
  }
}
