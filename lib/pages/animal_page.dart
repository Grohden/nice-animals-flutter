import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/shibe/service/shibe_service.dart';
import 'package:nice_animals_flutter/util/listener/bottom_reach.dart';
import 'package:nice_animals_flutter/widgets/animal_card.dart';
import 'package:nice_animals_flutter/widgets/app_loader.dart';

class AnimalListScreen extends StatefulWidget {
  AnimalType type;

  AnimalListScreen(AnimalType type) {
    this.type = type;
  }

  @override
  _AnimalListScreenState createState() => new _AnimalListScreenState(type);
}

class _AnimalListScreenState extends State<AnimalListScreen>
    with AutomaticKeepAliveClientMixin<AnimalListScreen> {
  ScrollController listController = ScrollController();
  bool hasLoaded = false;
  bool isLoadingMore = false;
  List<String> shibes = [];
  AnimalType type;

  _AnimalListScreenState(AnimalType type) {
    this.type = type;
  }

  @override
  bool get wantKeepAlive => true;

  void loadMoreShibes() async {
    setState(() {
      isLoadingMore = true;
    });

    var loadedShibes = await ShibeService.get(type);

    setState(() {
      shibes = this.shibes + loadedShibes;
      isLoadingMore = false;
    });
  }

  void loadShibes() async {
    var loadedShibes = await ShibeService.get(type);

    setState(() {
      shibes = loadedShibes;
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
        children: List.generate(shibes.length, (index) {
          return Container(
            padding: EdgeInsets.all(3.5),
            child: AnimalCard(shibes[index]),
          );
        }),
      );
    }
  }
}
