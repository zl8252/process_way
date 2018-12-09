import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:process_way/process_way.dart';

class InstancesTab extends StatefulWidget {
  @override
  _InstancesTabState createState() => _InstancesTabState();
}

class _InstancesTabState extends State<InstancesTab>
    with AutomaticKeepAliveClientMixin {
  InstancesScreenBloc _instancesScreenBloc;

  ProcessesBloc get _processesBloc => BlocProvider.of<ProcessesBloc>(context);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _instancesScreenBloc = new InstancesScreenBloc();

    _instancesScreenBloc.outShowRunnerScreen.listen(_onOutShowRunnerScreen);
  }

  @override
  void dispose() {
    _instancesScreenBloc.dispose();

    super.dispose();
  }

  void _onOutShowRunnerScreen(ShowRunnerScreenInvoke invoke) {
    Navigator.of(context).push(
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return new RunningScreen(
            instanceId: invoke.instanceId,
          );
        },
      ),
    );
  }

  void _runInstance(InstanceBloc instance) {
    _instancesScreenBloc.inStartRunning.add(
      new StartRunningRequest(instanceId: instance.id),
    );
  }

  void _deleteInstance(InstanceBloc instance) {
    _processesBloc.inDeleteInstance.add(instance.id);
  }

  @override
  Widget build(BuildContext context) {
    return new BlocProvider<InstancesScreenBloc>(
      bloc: _instancesScreenBloc,
      child: new StreamBuilder<UnmodifiableListView<InstanceBloc>>(
        initialData: new UnmodifiableListView([]),
        stream: _processesBloc.instances,
        builder: (context, snapshot) {
          return new ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              InstanceBloc instance = snapshot.data[index];

              return new InstanceListItem(
                key: new ObjectKey(instance),
                bloc: instance,
                onRun: () => _runInstance(instance),
                onDelete: () => _deleteInstance(instance),
              );
            },
          );
        },
      ),
    );
  }
}
