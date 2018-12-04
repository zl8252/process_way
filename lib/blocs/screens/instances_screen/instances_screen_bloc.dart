import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

class InstancesScreenBloc extends BlocBase {
  InstancesScreenBloc() {
    _inStartRunningSubject.listen(_onInStartRunning);
  }

  // output
  final _outShowRunnerScreenSubject =
      new BehaviorSubject<ShowRunnerScreenInvoke>();

  Observable<ShowRunnerScreenInvoke> get outShowRunnerScreen =>
      _outShowRunnerScreenSubject;

  // input
  final _inStartRunningSubject = new BehaviorSubject<StartRunningRequest>();

  Sink<StartRunningRequest> get inStartRunning => _inStartRunningSubject;

  // input handling
  Future _onInStartRunning(StartRunningRequest request) async {
    int instanceId = request.instanceId;

    _outShowRunnerScreenSubject.add(
      new ShowRunnerScreenInvoke(
        instanceId: instanceId,
      ),
    );
  }

  // --

  @override
  void dispose() {
    _outShowRunnerScreenSubject.close();

    _inStartRunningSubject.close();
  }
}
