import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

@immutable
abstract class Component {
  @protected
  static const mapKey_componentType = "componentType";

  Component();

  ComponentType get type;

  Component.fromMap();

  Map toMap();

  @protected
  String get mapValueComponentType => componentTypeToString(type);
}
