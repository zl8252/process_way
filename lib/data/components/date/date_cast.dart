import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'package:process_way/process_way.dart';

class DateCast extends ComponentCast {
  static const _mapKey_date = "date";

  DateCast({
    @required this.date,
  }) : assert(date != null);

  factory DateCast.fromMap(Map map) {
    var d = map[_mapKey_date];
    return new DateCast(
      date: d == null
          ? new Optional.absent()
          : new Optional.of(new DateTime.fromMillisecondsSinceEpoch(d)),
    );
  }

  final Optional<DateTime> date;

  @override
  ComponentType get type => ComponentType.checkboxComponent;

  DateCast copyWith({
    Optional<DateTime> date,
  }) {
    return new DateCast(
      date: date ?? this.date,
    );
  }

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _mapKey_date: date.isPresent ? date.value.millisecondsSinceEpoch : null,
      };

  @override
  String toString() {
    return 'DateCast{date: $date}';
  }
}
