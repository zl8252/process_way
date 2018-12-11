import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_number_shared.dart';

class NumberTemplateBloc extends NumberShared
    implements IComponentTemplateBloc {
  static const _key_mold = "mold";

  NumberTemplateBloc({
    @required NumberMold mold,
  }) : super(mold: mold){
    _inCreateInstanceSubject.listen(_onInCreateInstance);
  }

  static NumberTemplateBloc fromMap(Map map) {
    return new NumberTemplateBloc(
      mold: NumberMold.fromMap(map[_key_mold]),
    );
  }

  final _inCreateInstanceSubject =
      new PublishSubject<Completer<IComponentInstanceBloc>>();

  @override
  Sink<Completer<IComponentInstanceBloc>> get inCreateInstance =>
      _inCreateInstanceSubject;

  Future _onInCreateInstance(Completer completer) async {
    final instance = NumberInstanceBloc(
      mold: mold,
      cast: mold.createCast(),
    );

    completer.complete(instance);
  }

  @override
  Future<Map> toMap() async {
    return <String, dynamic>{
      "bloc": "NumberTemplateBloc",
      _key_mold: mold.toMap(),
    };
  }

  @override
  void dispose() {
    super.dispose();

    _inCreateInstanceSubject.close();
  }
}
