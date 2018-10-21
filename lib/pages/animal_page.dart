import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/shibe/service/shibe_service.dart';
import 'package:nice_animals_flutter/widgets/app_loader.dart';

class ShibeScreen extends StatefulWidget {
  AnimalType type = null;

  ShibeScreen(AnimalType type) {
    this.type = type;
  }

  @override
  _ShibeScreenState createState() => new _ShibeScreenState(type);
}

class _ShibeScreenState extends State<ShibeScreen>
    with AutomaticKeepAliveClientMixin<ShibeScreen> {
  bool hasLoaded = false;
  List<String> shibes = [];
  AnimalType type;

  _ShibeScreenState(AnimalType type) {
    this.type = type;
  }

  @override
  bool get wantKeepAlive => true;

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
        children: List.generate(shibes.length, (index) {
          return Container(
            padding: EdgeInsets.all(5.0),
            child: Image.network(
              shibes[index],
              fit: BoxFit.cover,
            ),
          );
        }),
      );
    }
  }
}
