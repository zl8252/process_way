import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class TextMold extends ComponentMold {
  static const _key_text = "text";

  TextMold({
    @required this.text,
  }) : assert(text != null);

  static TextMold fromMap(Map map) {
    return new TextMold(
      text: map[_key_text],
    );
  }

  final String text;

  @override
  ComponentType get type => ComponentType.text;

  @override
  ComponentCast createCast() {
    return new TextCast();
  }

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _key_text: text,
      };

  TextMold copyWith({
    String text,
  }) {
    return new TextMold(
      text: text ?? this.text,
    );
  }

  @override
  String toString() {
    return 'TextMold{text: $text}';
  }
}
