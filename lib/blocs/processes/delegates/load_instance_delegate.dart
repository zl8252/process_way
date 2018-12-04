import 'dart:async';

import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

@immutable
class LoadInstanceDelegate {
  LoadInstanceDelegate({
    @required this.instanceId,
    @required this.completer,
  })  : assert(instanceId != null),
        assert(completer != null);

  final int instanceId;

  final Completer<InstanceBloc> completer;
}
