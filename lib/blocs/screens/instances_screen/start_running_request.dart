import 'package:meta/meta.dart';

@immutable
class StartRunningRequest {
  StartRunningRequest({
    @required this.instanceId,
  }) : assert(instanceId != null);

  final int instanceId;
}
