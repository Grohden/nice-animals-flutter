import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/pages/animal_page.dart';
import 'package:nice_animals_flutter/shibe/service/shibe_service.dart';

class NiceHomeScreen extends StatefulWidget {
  @override
  _NiceHomeState createState() => new _NiceHomeState();
}

class _NiceHomeState extends State<NiceHomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, initialIndex: 1, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nice Animals'),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(text: "Cats"),
            Tab(text: "Shibes"),
            Tab(text: "Birbs"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          ShibeScreen(AnimalType.cats),
          ShibeScreen(AnimalType.shibes),
          ShibeScreen(AnimalType.birds),
        ],
      ),
    );
  }
}
