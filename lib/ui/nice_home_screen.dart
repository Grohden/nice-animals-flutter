import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/data/nice_picture/nice_picture.dart';
import 'package:nice_animals_flutter/ui/pages/animal_page.dart';

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
          indicatorColor: Colors.accents.first,
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
          AnimalListScreen(AnimalType.cats),
          AnimalListScreen(AnimalType.shibes),
          AnimalListScreen(AnimalType.birds),
        ],
      ),
    );
  }
}
