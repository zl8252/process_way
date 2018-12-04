import 'package:flutter/material.dart';

import 'instances_tab/all.dart';
import 'templates_tab/all.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _navigationIndex;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(
      length: 2,
      vsync: this,
    );

    _navigationIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Process Way"),
      ),
      body: new TabBarView(
        controller: _tabController,
        physics: new NeverScrollableScrollPhysics(),
        children: <Widget>[
          new InstancesTab(),
          new TemplatesTab(),
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        currentIndex: _tabController.index,
        onTap: (index) {
          setState(() {
            _tabController.index = index;
          });
        },
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
            icon: new Icon(Icons.check_box),
            title: new Text("Instances"),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.list),
            title: new Text("Templates"),
          ),
        ],
      ),
    );
  }
}
