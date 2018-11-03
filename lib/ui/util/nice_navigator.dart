import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';
import 'package:nice_animals_flutter/ui/nice_fullscreen_gallery.dart';

class NiceNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void goToGallery(BuildContext context,
      {@required int initialPage, @required List<NicePicture> list}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NiceFullScreenGallery(
              initialPage: initialPage,
              list: list,
            ),
      ),
    );
  }
}
