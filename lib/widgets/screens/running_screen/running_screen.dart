import 'package:flutter/material.dart';

import 'package:process_way/process_way.dart';

class RunningScreen extends StatefulWidget {
  RunningScreen({
    @required this.instanceId,
  }) : assert(instanceId != null);

  final int instanceId;

  @override
  _RunningScreenState createState() => _RunningScreenState();
}

class _RunningScreenState extends State<RunningScreen> {
  RunningScreenBloc _runningScreenBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_runningScreenBloc == null) {
      _runningScreenBloc = new RunningScreenBloc(
        instanceId: widget.instanceId,
        processesBloc: BlocProvider.of<ProcessesBloc>(context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Instance Runner"),
        elevation: 0,
      ),
      body: new StreamBuilder<InstanceBloc>(
        stream: _runningScreenBloc.instance,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return new Container();

          return new Column(
            children: <Widget>[
              new InstanceInfoHeader(
                bloc: snapshot.data,
              ),
              new Expanded(
                child: new SingleChildScrollView(
                  child: new GroupInstance(
                    bloc: snapshot.data.rootGroup.value,
                    showHeader: false,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
