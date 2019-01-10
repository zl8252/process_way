import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'package:process_way/process_way.dart';

class DateMold extends ComponentMold {
  static const _mapKey_title = "title";

  DateMold({
    @required this.title,
  }) : assert(title != null);

  factory DateMold.fromMap(Map map) {
    return new DateMold(
      title: map[_mapKey_title],
    );
  }

  @override
  ComponentType get type => ComponentType.dateComponent;

  final String title;

  DateMold copyWith({
    String title,
  }) {
    return new DateMold(
      title: title ?? this.title,
    );
  }

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _mapKey_title: title,
      };

  @override
  DateCast createCast() {
    return new DateCast(
      date: new Optional.absent(),
    );
  }

  @override
  String toString() {
    return 'DateMold{title: $title}';
  }
}
