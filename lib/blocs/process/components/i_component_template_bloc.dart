import 'dart:async';

import 'package:process_way/process_way.dart';

abstract class IComponentTemplateBloc implements ComponentBloc {
  Sink<Completer<IComponentInstanceBloc>> get inCreateInstance;
}
