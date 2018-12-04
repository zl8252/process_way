import 'package:process_way/process_way.dart';

class GroupCast extends ComponentCast {
  GroupCast();

  factory GroupCast.fromMap(Map map) {
    return new GroupCast();
  }

  @override
  ComponentType get type => ComponentType.groupComponent;

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
      };
}
