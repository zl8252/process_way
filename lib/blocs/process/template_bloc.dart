import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

class TemplateBloc extends ProcessBloc {
  static const _key_id = "id";
  static const _key_mold = "mold";
  static const _key_rootGroup = "rootGroup";

  TemplateBloc({
    @required this.id,
    @required InfoMold mold,
    @required GroupTemplateBloc rootGroup,
  })  : assert(id != null),
        assert(rootGroup != null),
        _rootGroup = rootGroup,
        super(mold: mold) {
    _inCreateInstanceSubject.listen(_onInCreateInstance);
    _inToMapSubject.listen(_onInToMap);

    _updateRootGroupStream();
  }

  static TemplateBloc fromMap(Map map) {
    return new TemplateBloc(
      id: map[_key_id],
      mold: InfoMold.fromMap(map[_key_mold]),
      rootGroup: ComponentBloc.fromMap(map[_key_rootGroup]),
    );
  }

  final int id;

  final GroupTemplateBloc _rootGroup;

  // output
  final _rootGroupSubject = new BehaviorSubject<GroupTemplateBloc>();

  ValueObservable<GroupTemplateBloc> get rootGroup => _rootGroupSubject;

  // input
  final _inCreateInstanceSubject = new PublishSubject<CreateInstanceDelegate>();
  final _inToMapSubject = new PublishSubject<Completer<Map>>();

  Sink<CreateInstanceDelegate> get inCreateInstance => _inCreateInstanceSubject;

  @override
  Sink<Completer<Map>> get inToMap => _inToMapSubject;

  // input handling
  Future _onInCreateInstance(CreateInstanceDelegate delegate) async {
    Completer<GroupInstanceBloc> rootGroupCompleter = new Completer();
    _rootGroup.inCreateInstance.add(rootGroupCompleter);

    InstanceBloc instance = new InstanceBloc(
      id: delegate.instanceId,
      mold: mold,
      cast: mold.createCast(),
      rootGroup: await rootGroupCompleter.future,
    );

    delegate.completer.complete(instance);
  }

  Future _onInToMap(Completer<Map> completer) async {
    Completer<Map> toMapCompleter = new Completer();

    _rootGroup.inToMap.add(toMapCompleter);

    Map map = <String, dynamic>{
      "bloc": "TemplateBloc",
      _key_id: id,
      _key_mold: mold.toMap(),
      _key_rootGroup: await toMapCompleter.future,
    };

    completer.complete(map);
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
    _inToMapSubject.close();
  }

  @override
  String toString() {
    return 'TemplateBloc{title:${mold.title}, id:$id}';
  }
}
