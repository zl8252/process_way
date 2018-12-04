import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

class CheckboxInstance extends CheckboxTemplate implements IComponentInstance {
  CheckboxInstance({
    @required CheckboxMold mold,
    @required CheckboxCast cast,
  })  : assert(cast != null),
        _cast = cast,
        super(mold: mold) {
    _inIsCheckedSubject.listen(_onInIsChecked);

    _updateIsCheckedStream();
  }

  CheckboxCast _cast;

  // output
  final _isCheckedSubject = new BehaviorSubject<bool>();

  ValueObservable<bool> get isChecked => _isCheckedSubject;

  // input
  final _inIsCheckedSubject = new PublishSubject<bool>();

  Sink<bool> get inIsChecked => _inIsCheckedSubject;

  // input handling
  Future _onInIsChecked(bool data) async {
    _cast = _cast.copyWith(isChecked: data);

    _updateIsCheckedStream();
  }

  // --
  void _updateIsCheckedStream() {
    _isCheckedSubject.add(_cast.isChecked);
  }

  @override
  void dispose() {
    super.dispose();

    _isCheckedSubject.close();

    _inIsCheckedSubject.close();
  }
}
