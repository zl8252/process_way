import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

class RunningScreenBloc extends BlocBase {
  RunningScreenBloc({
    @required int instanceId,
    @required ProcessesBloc processesBloc,
  })  : assert(instanceId != null),
        assert(processesBloc != null),
        _instanceId = instanceId,
        _processesBloc = processesBloc {
    _inSaveAndDismissScreenSubject.listen(_onInSaveAndDismissScreen);

    _loadInstance();
  }

  final int _instanceId;
  InstanceBloc _instance;

  final ProcessesBloc _processesBloc;

  // output
  final _instanceSubject = new BehaviorSubject<InstanceBloc>();
  final _outDismissScreenSubject = new BehaviorSubject<Null>();

  Observable<InstanceBloc> get instance => _instanceSubject;

  Observable<Null> get outDismissScreen => _outDismissScreenSubject;

  // input
  final _inSaveAndDismissScreenSubject = new PublishSubject<Null>();

  Sink<Null> get inSaveAndDismissScreen => _inSaveAndDismissScreenSubject;

  // input handling
  Future _onInSaveAndDismissScreen(_) async {
    if (_instance == null) {
      _processesBloc.inSaveInstance.add(_instance);
    }
    _dismissScreen();
  }

  // --
  void _updateInstanceStream() {
    _instanceSubject.add(_instance);
  }

  void _dismissScreen() {
    _outDismissScreenSubject.add(Null);
  }

  Future _loadInstance() async {
    Completer<InstanceBloc> instanceCompleter = new Completer();
    _processesBloc.inLoadInstance.add(
      new LoadInstanceDelegate(
        instanceId: _instanceId,
        completer: instanceCompleter,
      ),
    );
    _instance = await instanceCompleter.future;

    _updateInstanceStream();
  }

  @override
  void dispose() {
    _instanceSubject.close();
    _outDismissScreenSubject.close();

    _inSaveAndDismissScreenSubject.close();
  }
}
