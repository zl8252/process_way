import 'package:quiver/core.dart';

import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class NumberCast extends ComponentCast {
  static const _key_value = "value";

  NumberCast({
    @required this.value,
  }) : assert(value != null);

  static NumberCast fromMap(Map map) {
    return new NumberCast(
      value: new Optional.fromNullable(map[_key_value]),
    );
  }

  final Optional<double> value;

  @override
  ComponentType get type => ComponentType.number;

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _key_value: value.orNull,
      };

  NumberCast copyWith({
    Optional<double> value,
  }) {
    return new NumberCast(
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return 'NumberCast{value: $value}';
  }
}
