import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

@immutable
class MoveInstanceRequest {
  MoveInstanceRequest({
    @required this.direction,
    @required this.instance,
  })  : assert(direction != null),
        assert(instance != null);

  final MoveItemDirection direction;

  final InstanceBloc instance;
}
