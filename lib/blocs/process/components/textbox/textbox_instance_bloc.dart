import 'dart:async';

import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_textbox_shared.dart';

class TextBoxInstanceBloc extends TextBoxShared
    implements IComponentInstanceBloc {
  static const _key_mold = "mold";
  static const _key_cast = "cast";

  TextBoxInstanceBloc({
    @required TextBoxMold mold,
    @required this.cast,
  })  : assert(cast != null),
        super(mold: mold) {
    _inTextSubject.listen(_onInText);

    _updateTextStream();
  }

  static TextBoxInstanceBloc fromMap(Map map) {
    return new TextBoxInstanceBloc(
      mold: TextBoxMold.fromMap(map[_key_mold]),
      cast: TextBoxCast.fromMap(map[_key_cast]),
    );
  }

  @protected
  TextBoxCast cast;

  final _textSubject = new BehaviorSubject<String>();

  ValueObservable<String> get text => _textSubject;

  final _inTextSubject = new PublishSubject<String>();

  Sink<String> get inText => _inTextSubject;

  Future _onInText(String data) async {
    cast = cast.copyWith(text: data);

    _updateTextStream();
  }

  void _updateTextStream() {
    _textSubject.add(cast.text);
  }

  @override
  Future<Map> toMap() async {
    return <String, dynamic>{
      "bloc": "TextBoxInstanceBloc",
      _key_mold: mold.toMap(),
      _key_cast: cast.toMap(),
    };
  }

  @override
  void dispose() {
    super.dispose();

    _textSubject.close();
    _inTextSubject.close();
  }
}
