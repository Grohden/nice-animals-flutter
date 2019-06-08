import 'package:flutter/material.dart';

class OnBottomReach {
  OnBottomReach(ScrollController container, VoidCallback callback,
      {double sensitivity: 200.0}) {
    container.addListener(() {
      final maxScroll = container.position.maxScrollExtent;
      final currentScroll = container.position.pixels;
      if (maxScroll - currentScroll <= sensitivity) {
        callback();
      }
    });
  }
}
