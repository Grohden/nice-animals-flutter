import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';

class AnimalCard extends StatelessWidget {
  const AnimalCard({@required this.picture, this.onTap}) : super();

  final NicePicture picture;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(2.0),
          child: CachedNetworkImage(
            imageUrl: picture.url,
            placeholder: Center(child: const CircularProgressIndicator()),
            errorWidget: Image.asset('assets/image_not_found.png'),
            fit: BoxFit.cover,
          )),
    );
  }
}
