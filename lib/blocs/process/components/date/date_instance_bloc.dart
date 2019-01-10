import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:quiver/core.dart';

import 'package:process_way/process_way.dart';

import '_date_shared.dart';

class DateInstanceBloc extends DateShared implements IComponentInstanceBloc {
  static const _key_mold = "mold";
  static const _key_cast = "cast";

  DateInstanceBloc({
    @required DateMold mold,
    @required DateCast cast,
  })  : assert(cast != null),
        _cast = cast,
        super(mold: mold) {
    _inDateSubject.listen(_onInDate);

    _updateIsDateStream();
  }

  static DateInstanceBloc fromMap(Map map) {
    return new DateInstanceBloc(
      mold: new DateMold.fromMap(map[_key_mold]),
      cast: new DateCast.fromMap(map[_key_cast]),
    );
  }

  DateCast _cast;

  // output
  final _dateSubject = new BehaviorSubject<Optional<DateTime>>();

  ValueObservable<Optional<DateTime>> get date => _dateSubject;

  // input
  final _inDateSubject = new PublishSubject<Optional<DateTime>>();

  Sink<Optional<DateTime>> get inDate => _inDateSubject;

  // input handling
  Future _onInDate(Optional<DateTime> data) async {
    _cast = _cast.copyWith(date: data);

    _updateIsDateStream();
  }

  // --
  void _updateIsDateStream() {
    _dateSubject.add(_cast.date);
  }

  @override
  String toExportString() {
    String dateString = "__.__.____";
    if (_cast.date.isPresent) {
      dateString =
          "${_cast.date.value.day}.${_cast.date.value.month}.${_cast.date.value.year}";
    }

    return "${mold.title}: $dateString";
  }

  @override
  Future<Map> toMap() async {
    return <String, dynamic>{
      "bloc": "DateInstanceBloc",
      _key_mold: mold.toMap(),
      _key_cast: _cast.toMap(),
    };
  }

  @override
  void dispose() {
    super.dispose();

    _dateSubject.close();

    _inDateSubject.close();
  }
}
