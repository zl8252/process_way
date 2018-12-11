import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'package:process_way/process_way.dart';

class NumberMold extends ComponentMold {
  static const _key_label = "label";

  NumberMold({
    @required this.label,
  }) : assert(label != null);

  static NumberMold fromMap(Map map) {
    return new NumberMold(
      label: map[_key_label],
    );
  }

  final String label;

  @override
  ComponentType get type => ComponentType.number;

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _key_label: label,
      };

  @override
  NumberCast createCast() {
    return new NumberCast(
      value: new Optional<double>.absent(),
    );
  }

  NumberMold copyWith({
    String label,
  }) {
    return new NumberMold(
      label: label ?? this.label,
    );
  }

  @override
  String toString() {
    return 'NumberMold{label: $label}';
  }
}
