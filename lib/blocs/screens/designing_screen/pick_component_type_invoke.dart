import 'dart:async';

import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

@immutable
class PickComponentTypeInvoke {
  PickComponentTypeInvoke({
    @required this.completer,
  }) : assert(completer != null);

  final Completer<ComponentType> completer;
}
