import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class GalleryScreen extends StatelessWidget {
  GalleryScreen(this.url);

  final String url;

  @override
  Widget build(BuildContext context) {
    final background = Colors.black;

    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: background,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('A nice shibe'),
          backgroundColor: background.withOpacity(0.5),
        ),
        body: _buildPhoto(),
      ),
    );
  }

  Center _buildPhoto() {
    return Center(
      child: PhotoView(
        heroAttributes: PhotoViewHeroAttributes(tag: url),
        imageProvider: CachedNetworkImageProvider(url),
        loadingBuilder: (_, __) {
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
