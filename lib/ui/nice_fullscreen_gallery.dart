import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';

class NiceFullScreenGallery extends StatefulWidget {
  int initialPage;
  List<NicePicture> list;

  NiceFullScreenGallery({@required this.initialPage, @required this.list})
      : super();

  @override
  _NiceFullScreenGalleryState createState() =>
      _NiceFullScreenGalleryState(initialPage, list);
}

class _NiceFullScreenGalleryState extends State<NiceFullScreenGallery> {
  List<NicePicture> list;
  int initialPage;
  PageController controller;

  _NiceFullScreenGalleryState(this.initialPage, this.list) : super() {
    this.controller = PageController(initialPage: initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: CloseButton(),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0.7,
      ),
      body: PageView.builder(
        controller: controller,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return CachedNetworkImage(
            imageUrl: list[index].url,
            placeholder: Center(child: CircularProgressIndicator()),
            errorWidget: Image.asset("assets/image_not_found.png"),
            fit: BoxFit.fitWidth,
          );
        },
      ),
    );
  }
}