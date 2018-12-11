import 'dart:async';

import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_text_shared.dart';

class TextInstanceBloc extends TextShared implements IComponentInstanceBloc {
  static const _key_mold = "mold";

  TextInstanceBloc({
    @required TextMold mold,
  }) : super(mold: mold);

  static TextInstanceBloc fromMap(Map map) {
    return new TextInstanceBloc(
      mold: TextMold.fromMap(map[_key_mold]),
    );
  }

  @override
  Future<Map> toMap() async {
    return <String, dynamic>{
      "bloc": "TextInstanceBloc",
      _key_mold: mold.toMap(),
    };
  }
}
