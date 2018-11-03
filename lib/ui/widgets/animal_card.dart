import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';

class AnimalCard extends StatelessWidget {
  final NicePicture picture;

  AnimalCard(this.picture) : super();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: new BorderRadius.circular(2.0),
        child: CachedNetworkImage(
          imageUrl: picture.url,
          placeholder: Center(child: CircularProgressIndicator()),
          errorWidget: Image.asset("assets/image_not_found.png"),
          fit: BoxFit.cover,
        ));
  }
}
