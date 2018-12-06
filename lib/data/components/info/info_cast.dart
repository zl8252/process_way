import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class InfoCast extends ComponentCast {
  static const _mapKey_isCompleted = "isCompleted";
  static const _mapKey_instanceName = "instanceName";

  InfoCast({
    @required this.isCompleted,
    @required this.instanceName,
  })  : assert(isCompleted != null),
        assert(instanceName != null);

  factory InfoCast.fromMap(Map map) {
    return new InfoCast(
      isCompleted: map[_mapKey_isCompleted],
      instanceName: map[_mapKey_instanceName],
    );
  }

  final bool isCompleted;
  final String instanceName;

  @override
  ComponentType get type => ComponentType.infoComponent;

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _mapKey_isCompleted: isCompleted,
        _mapKey_instanceName: instanceName,
      };

  InfoCast copyWith({
    bool isCompleted,
    String instanceName,
  }) {
    return new InfoCast(
      isCompleted: isCompleted ?? this.isCompleted,
      instanceName: instanceName ?? this.instanceName,
    );
  }

  @override
  String toString() {
    return 'InfoCast{isCompleted: $isCompleted, instanceName: $instanceName}';
  }
}
