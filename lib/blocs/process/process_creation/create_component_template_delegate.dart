import 'dart:async';

import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

@immutable
class CreateComponentTemplateDelegate {
  CreateComponentTemplateDelegate({
    @required this.componentType,
    @required this.completer,
  })  : assert(componentType != null),
        assert(completer != null);

  final ComponentType componentType;

  final Completer<IComponentTemplateBloc> completer;
}
