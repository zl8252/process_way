import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

class InstanceBloc extends ProcessBloc {
  InstanceBloc({
    @required this.id,
    @required InfoMold mold,
    @required InfoCast cast,
    @required GroupInstance rootGroup,
  })  : assert(id != null),
        assert(cast != null),
        assert(rootGroup != null),
        _cast = cast,
        _rootGroup = rootGroup,
        super(mold: mold) {
    _inIsCompletedSubject.listen(_onInIsCompleted);

    _updateIsCompletedStream();
    _updateRootGroupStream();
  }

  final int id;

  InfoCast _cast;

  final GroupInstance _rootGroup;

  // output
  final _isCompletedSubject = new BehaviorSubject<bool>();
  final _rootGroupSubject = new BehaviorSubject<GroupInstance>();

  ValueObservable<bool> get isCompleted => _isCompletedSubject;

  ValueObservable<GroupInstance> get rootGroup => _rootGroupSubject;

  // input
  final _inIsCompletedSubject = new PublishSubject<bool>();

  Sink<bool> get inIsCompleted => _inIsCompletedSubject;

  // input handling
  Future _onInIsCompleted(bool data) async {
    _cast = _cast.copyWith(isCompleted: data);

    _updateIsCompletedStream();
  }

// --
  void _updateIsCompletedStream() {
    _isCompletedSubject.add(_cast.isCompleted);
  }

  void _updateRootGroupStream() {
    _rootGroupSubject.add(_rootGroup);
  }

  @override
  void dispose() {
    super.dispose();

    _isCompletedSubject.close();
    _rootGroupSubject.close();

    _inIsCompletedSubject.close();
  }
}
