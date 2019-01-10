import 'dart:async';

import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_date_shared.dart';

class DateTemplateBloc extends DateShared implements IComponentTemplateBloc {
  static const _key_mold = "mold";

  DateTemplateBloc({
    @required DateMold mold,
  }) : super(mold: mold);

  static DateTemplateBloc fromMap(Map map) {
    return new DateTemplateBloc(
      mold: new DateMold.fromMap(map[_key_mold]),
    );
  }

  @override
  Future<Map> toMap() async {
    return <String, dynamic>{
      "bloc": "DateTemplateBloc",
      _key_mold: mold.toMap(),
    };
  }
}
