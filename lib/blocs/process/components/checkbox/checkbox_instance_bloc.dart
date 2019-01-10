import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_checkbox_shared.dart';

class CheckboxInstanceBloc extends CheckboxShared
    implements IComponentInstanceBloc {
  static const _key_mold = "mold";
  static const _key_cast = "cast";

  CheckboxInstanceBloc({
    @required CheckboxMold mold,
    @required CheckboxCast cast,
  })  : assert(cast != null),
        _cast = cast,
        super(mold: mold) {
    _inIsCheckedSubject.listen(_onInIsChecked);

    _updateIsCheckedStream();
  }

  static CheckboxInstanceBloc fromMap(Map map) {
    return new CheckboxInstanceBloc(
      mold: new CheckboxMold.fromMap(map[_key_mold]),
      cast: new CheckboxCast.fromMap(map[_key_cast]),
    );
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
  String toExportString() {
    return "[${_cast.isChecked ? "X": " "}] ${mold.title} ${mold.subtitle.or("")}";
  }

  @override
  Future<Map> toMap() async {
    return <String, dynamic>{
      "bloc": "CheckboxInstanceBloc",
      _key_mold: mold.toMap(),
      _key_cast: _cast.toMap(),
    };
  }

  @override
  void dispose() {
    super.dispose();

    _isCheckedSubject.close();

    _inIsCheckedSubject.close();
  }
}
