import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

@immutable
class MoveTemplateRequest {
  MoveTemplateRequest({
    @required this.direction,
    @required this.template,
  })  : assert(direction != null),
        assert(template != null);

  final MoveItemDirection direction;

  final TemplateBloc template;
}
