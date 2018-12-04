import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class InfoCast extends ComponentCast {
  static const _mapKey_isCompleted = "isCompleted";

  InfoCast({
    @required this.isCompleted,
  }) : assert(isCompleted != null);

  factory InfoCast.fromMap(Map map) {
    return new InfoCast(
      isCompleted: map[_mapKey_isCompleted],
    );
  }

  final bool isCompleted;

  @override
  ComponentType get type => ComponentType.infoComponent;

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _mapKey_isCompleted: isCompleted,
      };

  InfoCast copyWith({
    bool isCompleted,
  }) {
    return new InfoCast(
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() {
    return 'InfoCast{isCompleted: $isCompleted}';
  }
}
