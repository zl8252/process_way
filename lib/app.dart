import 'package:flutter/material.dart';

import 'package:process_way/process_way.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  ProcessCreationBloc _processCreationBloc;
  ProcessesBloc _processesBloc;

  @override
  void initState() {
    super.initState();

    _processCreationBloc = new ProcessCreationBloc();

    _processesBloc = new ProcessesBloc(
      instancesRepository: new InstancesRepository(),
      templatesRepository: new TemplatesRepository(),
      processCreationBloc: _processCreationBloc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new BlocProvider<ProcessCreationBloc>(
      bloc: _processCreationBloc,
      child: new BlocProvider<ProcessesBloc>(
        bloc: _processesBloc,
        child: new MaterialApp(
          title: "Process Way",
          home: new MainScreen(),
        ),
      ),
    );
  }
}
