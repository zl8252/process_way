import 'package:flutter/material.dart';

import 'instances_tab/all.dart';
import 'templates_tab/all.dart';

import 'package:process_way/process_way.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = new TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Process Way"),
      ),
      body: new _InstanceCreatedNotifier(
        child: new TabBarView(
          controller: _tabController,
          physics: new NeverScrollableScrollPhysics(),
          children: <Widget>[
            new InstancesTab(),
            new TemplatesTab(),
          ],
        ),
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

class _InstanceCreatedNotifier extends StatefulWidget {
  _InstanceCreatedNotifier({
    @required this.child,
  }) : assert(child != null);

  final Widget child;

  @override
  __InstanceCreatedNotifierState createState() =>
      __InstanceCreatedNotifierState();
}

class __InstanceCreatedNotifierState extends State<_InstanceCreatedNotifier> {
  bool _isSubscribed;

  @override
  void initState() {
    super.initState();

    _isSubscribed = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isSubscribed) {
      _isSubscribed = true;

      BlocProvider.of<ProcessesBloc>(context)
          .outInstanceCreatedNotification
          .listen(_onInstanceCreatedNotification);
    }
  }

  void _onInstanceCreatedNotification(_) {
    Scaffold.of(context).showSnackBar(
      new SnackBar(
        duration: new Duration(seconds: 1),
        content: new Text("Instance Created"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
