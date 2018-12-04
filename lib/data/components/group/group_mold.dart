import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class GroupMold extends ComponentMold {
  static const _mapKey_title = "title";

  GroupMold({
    @required this.title,
  }) : assert(title != null);

  factory GroupMold.fromMap(Map map) {
    return new GroupMold(
      title: map[_mapKey_title],
    );
  }

  final String title;

  @override
  ComponentType get type => ComponentType.groupComponent;

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _mapKey_title: title,
      };

  @override
  GroupCast createCast() {
    return new GroupCast();
  }

  GroupMold copyWith({
    String title,
  }) {
    return new GroupMold(
      title: title ?? this.title,
    );
  }

  @override
  String toString() {
    return 'GroupMold{title: $title}';
  }
}
