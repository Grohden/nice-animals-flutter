import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  String animalUrl;

  AnimalCard(String animalUrl) {
    this.animalUrl = animalUrl;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: new BorderRadius.circular(2.0),
        child: CachedNetworkImage(
          imageUrl: animalUrl,
          placeholder: Center(child: CircularProgressIndicator()),
          errorWidget: Image.asset("assets/image_not_found.png"),
          fit: BoxFit.cover,
        ));
  }
}
