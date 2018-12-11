import 'dart:async';

import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_checkbox_shared.dart';

class CheckboxTemplateBloc extends CheckboxShared
    implements IComponentTemplateBloc {
  static const _key_mold = "mold";

  CheckboxTemplateBloc({
    @required CheckboxMold mold,
  }) : super(mold: mold);

  static CheckboxTemplateBloc fromMap(Map map) {
    return new CheckboxTemplateBloc(
      mold: new CheckboxMold.fromMap(map[_key_mold]),
    );
  }

  @override
  Future<Map> toMap() async {
    return <String, dynamic>{
      "bloc": "CheckboxTemplateBloc",
      _key_mold: mold.toMap(),
    };
  }
}
