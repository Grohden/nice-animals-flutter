import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:niceanimals/ui/screen/gallery_screen.dart';
import 'package:shibe_api/shibe_api.dart';

const aspectRatio = 1.0;

class HomeController extends RxController {
  final api = Get.find<ShibeApiService>();
  final loading = true.obs;
  final error = ''.obs;
  final dogs = <AnimalPicture>[].obs;

  @override
  void onInit() async {
    loading.value = true;
    final newDogs = await api.get(AnimalType.shibes);
    dogs.assignAll(newDogs);
    loading.value = false;
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final count = MediaQuery.of(context).size.width / 500;

    return Scaffold(
      appBar: AppBar(
        title: Text('Shibas'),
      ),
      body: GetX<HomeController>(
        init: HomeController(),
        builder: (_) {
          if (_.loading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: GridView.count(
              crossAxisCount: count.ceil(),
              childAspectRatio: aspectRatio,
              children: List.generate(
                _.dogs.value.length,
                (index) {
                  final animal = _.dogs.value[index];

                  return _buildImage(animal);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImage(AnimalPicture animal) {
    return InkWell(
      onTap: () => Get.to(GalleryScreen(animal.url)),
      hoverColor: Colors.red,
      child: Hero(
        tag: animal.url,
        // Without fitted box, we lose frame rate. TODO: find out why
        child: FittedBox(
          fit: BoxFit.cover,
          child: CachedNetworkImage(
            imageUrl: animal.url,
            fit: BoxFit.none,
            placeholder: (context, url) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            errorWidget: (context, url, error) =>
                Image.asset('assets/image_not_found.png'),
          ),
        ),
      ),
    );
  }
}
