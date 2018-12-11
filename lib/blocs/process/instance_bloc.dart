import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

class InstanceBloc extends ProcessBloc {
  static const _key_id = "id";
  static const _key_mold = "mold";
  static const _key_cast = "cast";
  static const _key_rootGroup = "rootGroup";

  InstanceBloc({
    @required this.id,
    @required InfoMold mold,
    @required InfoCast cast,
    @required GroupInstanceBloc rootGroup,
  })  : assert(id != null),
        assert(cast != null),
        assert(rootGroup != null),
        _cast = cast,
        _rootGroup = rootGroup,
        super(mold: mold) {
    _inInstanceNameSubject.listen(_onInInstanceName);
    _inIsCompletedSubject.listen(_onInIsCompleted);
    _inToMapSubject.listen(_onInToMap);

    _updateInstanceNameStream();
    _updateIsCompletedStream();
    _updateRootGroupStream();
  }

  static InstanceBloc fromMap(Map map) {
    return new InstanceBloc(
      id: map[_key_id],
      mold: InfoMold.fromMap(map[_key_mold]),
      cast: InfoCast.fromMap(map[_key_cast]),
      rootGroup: ComponentBloc.fromMap(map[_key_rootGroup]),
    );
  }

  final int id;

  InfoCast _cast;

  final GroupInstanceBloc _rootGroup;

  // output
  final _instanceNameSubject = new BehaviorSubject<String>();
  final _isCompletedSubject = new BehaviorSubject<bool>();
  final _rootGroupSubject = new BehaviorSubject<GroupInstanceBloc>();

  ValueObservable<String> get instanceName => _instanceNameSubject;

  ValueObservable<bool> get isCompleted => _isCompletedSubject;

  ValueObservable<GroupInstanceBloc> get rootGroup => _rootGroupSubject;

  // input
  final _inInstanceNameSubject = new PublishSubject<String>();
  final _inIsCompletedSubject = new PublishSubject<bool>();
  final _inToMapSubject = new PublishSubject<Completer<Map>>();

  Sink<String> get inInstanceName => _inInstanceNameSubject;

  Sink<bool> get inIsCompleted => _inIsCompletedSubject;

  Sink<Completer<Map>> get inToMap => _inToMapSubject;

  // input handling
  Future _onInInstanceName(String data) async {
    _cast = _cast.copyWith(instanceName: data);

    _updateInstanceNameStream();
  }

  Future _onInIsCompleted(bool data) async {
    _cast = _cast.copyWith(isCompleted: data);

    _updateIsCompletedStream();
  }

  Future _onInToMap(Completer<Map> completer) async {
    Completer<Map> rootGroupCompleter = new Completer();

    _rootGroup.inToMap.add(rootGroupCompleter);

    Map map = <String, dynamic>{
      "bloc": "InstnceBloc",
      _key_id: id,
      _key_mold: mold.toMap(),
      _key_cast: _cast.toMap(),
      _key_rootGroup: await rootGroupCompleter.future,
    };

    completer.complete(map);
  }

  // --
  void _updateInstanceNameStream() {
    _instanceNameSubject.add(_cast.instanceName);
  }

  void _updateIsCompletedStream() {
    _isCompletedSubject.add(_cast.isCompleted);
  }

  void _updateRootGroupStream() {
    _rootGroupSubject.add(_rootGroup);
  }

  @override
  void dispose() {
    super.dispose();

    _instanceNameSubject.close();
    _isCompletedSubject.close();
    _rootGroupSubject.close();

    _instanceNameSubject.close();
    _inIsCompletedSubject.close();
    _inToMapSubject.close();
  }
}
