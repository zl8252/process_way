import 'package:meta/meta.dart';

@immutable
class ShowRunnerScreenInvoke {
  ShowRunnerScreenInvoke({
    @required this.instanceId,
  }) : assert(instanceId != null);

  final instanceId;
}
