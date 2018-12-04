import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'package:process_way/process_way.dart';

class CheckboxMold extends ComponentMold {
  static const _mapKey_initialValue = "initialValue";
  static const _mapKey_title = "title";
  static const _mapKey_subtitle = "subtitle";

  CheckboxMold({
    @required this.initialValue,
    @required this.title,
    @required this.subtitle,
  })  : assert(initialValue != null),
        assert(title != null),
        assert(subtitle != null);

  factory CheckboxMold.fromMap(Map map) {
    return new CheckboxMold(
      initialValue: map[_mapKey_title],
      title: map[_mapKey_title],
      subtitle: new Optional.fromNullable(map[_mapKey_subtitle]),
    );
  }

  @override
  ComponentType get type => ComponentType.checkboxComponent;

  final bool initialValue;
  final String title;
  final Optional<String> subtitle;

  CheckboxMold copyWith({
    bool initialValue,
    String title,
    Optional<String> subtitle,
  }) {
    return new CheckboxMold(
      initialValue: initialValue ?? this.initialValue,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _mapKey_initialValue: initialValue,
        _mapKey_title: title,
        _mapKey_subtitle: subtitle.orNull,
      };

  @override
  CheckboxCast createCast() {
    return new CheckboxCast(
      isChecked: initialValue,
    );
  }

  @override
  String toString() {
    return 'CheckboxMold{initialValue: $initialValue, title: $title, subtitle: $subtitle}';
  }
}
