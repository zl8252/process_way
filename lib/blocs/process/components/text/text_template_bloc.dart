import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_text_shared.dart';

class TextTemplateBloc extends TextShared implements IComponentTemplateBloc {
  static const _key_mold = "mold";

  TextTemplateBloc({
    @required TextMold mold,
  }) : super(mold: mold) {
    _inCreateInstanceSubject.listen(_onInCreateInstance);
  }

  static TextTemplateBloc fromMap(Map map) {
    return new TextTemplateBloc(
      mold: TextMold.fromMap(map[_key_mold]),
    );
  }

  final _inCreateInstanceSubject =
      new PublishSubject<Completer<IComponentInstanceBloc>>();

  @override
  Sink<Completer<IComponentInstanceBloc>> get inCreateInstance =>
      _inCreateInstanceSubject;

  Future _onInCreateInstance(Completer completer) async {
    final instance = new TextInstanceBloc(mold: mold);

    completer.complete(instance);
  }

  @override
  Future<Map> toMap() async {
    return <String, dynamic>{
      "bloc": "TextTemplateBloc",
      _key_mold: mold.toMap(),
    };
  }

  @override
  void dispose() {
    super.dispose();

    _inCreateInstanceSubject.close();
  }
}
