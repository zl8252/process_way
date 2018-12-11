import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'package:process_way/process_way.dart';

class TextBoxMold extends ComponentMold {
  static const _key_title = "title";
  static const _key_hint = "hint";

  TextBoxMold({
    @required this.title,
    @required this.hint,
  })  : assert(title != null),
        assert(hint != null);

  static TextBoxMold fromMap(Map map) {
    return new TextBoxMold(
      title: map[_key_title],
      hint: new Optional<String>.fromNullable(map[_key_hint]),
    );
  }

  final String title;
  final Optional<String> hint;

  @override
  ComponentType get type => ComponentType.textBox;

  @override
  ComponentCast createCast() {
    return new TextBoxCast(text: "");
  }

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _key_title: title,
        _key_hint: hint.orNull,
      };

  TextBoxMold copyWith({
    String title,
    Optional<String> hint,
  }) {
    return new TextBoxMold(
      title: title ?? this.title,
      hint: hint ?? this.hint,
    );
  }

  @override
  String toString() {
    return 'TextBoxMold{title: $title, hint: $hint}';
  }
}
