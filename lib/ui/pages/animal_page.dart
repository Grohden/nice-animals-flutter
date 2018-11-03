import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture_repository.dart';
import 'package:nice_animals_flutter/data/nice_picture/specifications/all_by_type.dart';
import 'package:nice_animals_flutter/ui/shibe/service/shibe_service.dart';
import 'package:nice_animals_flutter/ui/util/listener/bottom_reach.dart';
import 'package:nice_animals_flutter/ui/util/nice_navigator.dart';
import 'package:nice_animals_flutter/ui/widgets/animal_card.dart';
import 'package:nice_animals_flutter/ui/widgets/app_loader.dart';

class AnimalListScreen extends StatefulWidget {
  final AnimalType type;

  const AnimalListScreen(this.type) : super();

  @override
  _AnimalListScreenState createState() => new _AnimalListScreenState(type);
}

class _AnimalListScreenState extends State<AnimalListScreen>
    with AutomaticKeepAliveClientMixin<AnimalListScreen> {
  ScrollController listController = ScrollController();
  bool hasLoaded = false;
  bool isLoadingMore = false;
  List<NicePicture> animals = [];
  AnimalType type;
  NicePictureRepository repository;

  _AnimalListScreenState(AnimalType type) {
    this.type = type;
    this.repository = NicePictureRepository();
  }

  @override
  bool get wantKeepAlive => true;

  void loadMoreShibes() async {
    setState(() {
      isLoadingMore = true;
    });

    var loadedAnimals = await ShibeService.get(type);

    setState(() {
      animals = this.animals + loadedAnimals;
      isLoadingMore = false;
    });
  }

  void loadShibes() async {
    await repository.open();
    var loadedAnimals = await repository.query(AllByType(type));
    if (loadedAnimals.length < 1) {
      loadedAnimals = await ShibeService.get(type);
    }
    await repository.insertOrUpdateAll(loadedAnimals);
    await repository.close();

    setState(() {
      animals = loadedAnimals;
      hasLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    if (!hasLoaded) {
      loadShibes();

      OnBottomReach(listController, () {
        if (!isLoadingMore) {
          loadMoreShibes();
        }
      }, sensitivity: 400.0);
    }
  }

  _openPicture(int index) {
    NiceNavigator.goToGallery(context, initialPage: index, list: animals);
  }

  @override
  Widget build(BuildContext context) {
    if (!hasLoaded) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[AppLoader()],
      ));
    } else {
      return GridView.count(
        crossAxisCount: 2,
        controller: listController,
        children: List.generate(animals.length, (index) {
          return Container(
            padding: EdgeInsets.all(3.5),
            child: AnimalCard(
                picture: animals[index],
                onTap: () {
                  _openPicture(index);
                }),
          );
        }),
      );
    }
  }
}
