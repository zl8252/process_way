import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

enum MoveItemDirection {
  up,
  down,
}

@immutable
class MoveItemRequest {
  MoveItemRequest({
    @required this.item,
    @required this.direction,
  })  : assert(item != null),
        assert(direction != null);

  final IComponentTemplateBloc item;

  final MoveItemDirection direction;
}
