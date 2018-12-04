import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class CheckboxCast extends ComponentCast {
  static const _mapKey_isChecked = "isChecked";

  CheckboxCast({
    @required this.isChecked,
  }) : assert(isChecked != null);

  factory CheckboxCast.fromMap(Map map) {
    return new CheckboxCast(
      isChecked: map[_mapKey_isChecked],
    );
  }

  final bool isChecked;

  @override
  ComponentType get type => ComponentType.checkboxComponent;

  CheckboxCast copyWith({bool isChecked}) {
    return new CheckboxCast(
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _mapKey_isChecked: isChecked,
      };

  @override
  String toString() {
    return 'CheckboxTask{isChecked: $isChecked}';
  }
}
