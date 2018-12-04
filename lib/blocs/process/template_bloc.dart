import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

class TemplateBloc extends ProcessBloc {
  TemplateBloc({
    @required this.id,
    @required InfoMold mold,
    @required GroupTemplate rootGroup,
  })  : assert(id != null),
        assert(rootGroup != null),
        _rootGroup = rootGroup,
        super(mold: mold) {
    _inCreateInstanceSubject.listen(_onInCreateInstance);

    _updateRootGroupStream();
  }

  final int id;

  final GroupTemplate _rootGroup;

  // output
  final _rootGroupSubject = new BehaviorSubject<GroupTemplate>();

  ValueObservable<GroupTemplate> get rootGroup => _rootGroupSubject;

  // input
  final _inCreateInstanceSubject = new PublishSubject<CreateInstanceDelegate>();

  Sink<CreateInstanceDelegate> get inCreateInstance => _inCreateInstanceSubject;

  // input handling
  Future _onInCreateInstance(CreateInstanceDelegate delegate) async {
    Completer<GroupInstance> rootGroupCompleter = new Completer();
    _rootGroup.inCreateInstance.add(rootGroupCompleter);

    InstanceBloc instance = new InstanceBloc(
      id: delegate.instanceId,
      mold: mold,
      cast: mold.createCast(),
      rootGroup: await rootGroupCompleter.future,
    );

    delegate.completer.complete(instance);
  }

  // --
  void _updateRootGroupStream() {
    _rootGroupSubject.add(_rootGroup);
  }

  @override
  void dispose() {
    super.dispose();

    _rootGroupSubject.close();

    _inCreateInstanceSubject.close();
  }

  @override
  String toString() {
    return 'TemplateBloc{title:${mold.title}, id:$id}';
  }
}
