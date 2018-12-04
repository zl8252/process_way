import 'dart:async';

import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

@immutable
class LoadTemplateDelegate {
  LoadTemplateDelegate({
    @required this.templateId,
    @required this.completer,
  })  : assert(templateId != null),
        assert(completer != null);

  final int templateId;

  final Completer<TemplateBloc> completer;
}
