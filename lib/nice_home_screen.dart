import 'package:flutter/material.dart';
import 'package:nice_animals_flutter/pages/shibes_page.dart';

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
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Nice Animals'),
        elevation: 0.7,
        bottom: new TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            new Tab(text: "Cats"),
            new Tab(text: "Shibes"),
            new Tab(text: "Birbs"),
          ],
        ),

      ),
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          new ShibeScreen(),
          new ShibeScreen(),
          new ShibeScreen(),
        ],
      ),
    );
  }
}
