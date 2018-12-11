import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_textbox_shared.dart';

class TextBoxTemplateBloc extends TextBoxShared
    implements IComponentTemplateBloc {
  static const _key_mold = "mold";

  TextBoxTemplateBloc({
    @required TextBoxMold mold,
  }) : super(mold: mold) {
    _inCreateInstanceSubject.listen(_onInCreateInstance);
  }

  static TextBoxTemplateBloc fromMap(Map map) {
    return new TextBoxTemplateBloc(
      mold: TextBoxMold.fromMap(map[_key_mold]),
    );
  }

  final _inCreateInstanceSubject =
      new PublishSubject<Completer<IComponentInstanceBloc>>();

  @override
  Sink<Completer<IComponentInstanceBloc>> get inCreateInstance =>
      _inCreateInstanceSubject;

  Future _onInCreateInstance(Completer completer) async {
    final instance = new TextBoxInstanceBloc(
      mold: mold,
      cast: mold.createCast(),
    );

    completer.complete(instance);
  }

  @override
  Future<Map> toMap() async {
    return <String, dynamic>{
      "bloc": "TextBoxTemplateBloc",
      _key_mold: mold.toMap(),
    };
  }

  @override
  void dispose() {
    super.dispose();

    _inCreateInstanceSubject.close();
  }
}
