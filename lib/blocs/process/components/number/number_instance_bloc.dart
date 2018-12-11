import 'dart:async';

import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_number_shared.dart';

class NumberInstanceBloc extends NumberShared
    implements IComponentInstanceBloc {
  static const _key_mold = "mold";
  static const _key_cast = "cast";

  NumberInstanceBloc({
    @required NumberMold mold,
    @required this.cast,
  })  : assert(cast != null),
        super(mold: mold) {
    _inValueSubject.listen(_onInValue);

    _updateValueStream();
  }

  static NumberInstanceBloc fromMap(Map map) {
    return new NumberInstanceBloc(
      mold: NumberMold.fromMap(map[_key_mold]),
      cast: NumberCast.fromMap(map[_key_cast]),
    );
  }

  @protected
  NumberCast cast;

  final _valueSubject = new BehaviorSubject<Optional<double>>();

  ValueObservable<Optional<double>> get value => _valueSubject;

  final _inValueSubject = new PublishSubject<Optional<double>>();

  Sink<Optional<double>> get inValue => _inValueSubject;

  Future _onInValue(Optional<double> data) async {
    cast = cast.copyWith(value: data);

    _updateValueStream();
  }

  void _updateValueStream() {
    _valueSubject.add(cast.value);
  }

  @override
  Future<Map> toMap() async {
    return <String, dynamic>{
      "bloc": "NumberInstanceBloc",
      _key_mold: mold.toMap(),
      _key_cast: cast.toMap(),
    };
  }

  @override
  void dispose() {
    super.dispose();

    _valueSubject.close();
    _inValueSubject.close();
  }
}
