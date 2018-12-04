import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'package:process_way/process_way.dart';

class InfoMold extends ComponentMold {
  static const _mapKey_title = "title";
  static const _mapKey_details = "details";

  InfoMold({
    @required this.title,
    @required this.details,
  })  : assert(title != null),
        assert(details != null);

  factory InfoMold.fromMap(Map map) {
    return new InfoMold(
      title: map[_mapKey_title],
      details: new Optional.fromNullable(map[_mapKey_details]),
    );
  }

  final String title;
  final Optional<String> details;

  @override
  ComponentType get type => ComponentType.infoComponent;

  @override
  Map toMap() => <String, dynamic>{
        Component.mapKey_componentType: mapValueComponentType,
        _mapKey_title: title,
        _mapKey_details: details.orNull,
      };

  @override
  InfoCast createCast() {
    return new InfoCast(
      isCompleted: false,
    );
  }

  InfoMold copyWith({
    String title,
    Optional<String> details,
  }) {
    return new InfoMold(
      title: title ?? this.title,
      details: details ?? this.details,
    );
  }

  @override
  String toString() {
    return 'InfoMold{title: $title, details: $details}';
  }
}
