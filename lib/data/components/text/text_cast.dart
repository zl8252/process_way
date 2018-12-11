import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class TextCast extends ComponentCast {
  TextCast();

  static TextCast fromMap(Map map) {
    return new TextCast();
  }

  @override
  ComponentType get type => ComponentType.text;

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
      };

  @override
  String toString() {
    return 'TextCast{}';
  }
}
