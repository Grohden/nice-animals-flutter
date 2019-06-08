import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';
import 'package:nice_animals_flutter/ui/util/nice_navigator.dart';

class NiceFullScreenGallery extends StatefulWidget {
  const NiceFullScreenGallery({@required this.initialPage, @required this.list})
      : super();

  final int initialPage;
  final List<NicePicture> list;

  @override
  _NiceFullScreenGalleryState createState() =>
      _NiceFullScreenGalleryState(initialPage, list);
}

class _NiceFullScreenGalleryState extends State<NiceFullScreenGallery> {
  _NiceFullScreenGalleryState(this.initialPage, this.list) : super() {
    controller = PageController(initialPage: initialPage);
    NiceNavigator.setStatusBarState(shown: false);
  }

  List<NicePicture> list;
  int initialPage;
  PageController controller;


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        NiceNavigator.setStatusBarState(shown: true);
        Navigator.pop(context, true);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: PageView.builder(
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              imageUrl: list[index].url,
              placeholder: Center(child: const CircularProgressIndicator()),
              errorWidget: Image.asset('assets/image_not_found.png'),
              fit: BoxFit.contain,
            );
          },
        ),
      ),
    );
  }
}
