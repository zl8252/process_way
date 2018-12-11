import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class TextBoxCast extends ComponentCast {
  static const _key_text = "text";

  TextBoxCast({
    @required this.text,
  }) : assert(text != null);

  static TextBoxCast fromMap(Map map) {
    return new TextBoxCast(
      text: map[_key_text],
    );
  }

  final String text;

  @override
  ComponentType get type => ComponentType.textBox;

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _key_text: text,
      };

  TextBoxCast copyWith({String text}) {
    return new TextBoxCast(
      text: text ?? this.text,
    );
  }

  @override
  String toString() {
    return 'TextBoxCast{text: $text}';
  }
}
