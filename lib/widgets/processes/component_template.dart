import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class ComponentTemplate extends StatelessWidget {
  ComponentTemplate({
    Key key,
    @required this.bloc,
  })  : assert(bloc != null),
        super(key: key);

  final IComponentTemplateBloc bloc;

  @override
  Widget build(BuildContext context) {
    switch (bloc.type) {
      case ComponentType.checkboxComponent:
        return new CheckboxTemplate(bloc: bloc);
      case ComponentType.groupComponent:
        return new GroupTemplate(bloc: bloc);
      case ComponentType.infoComponent:
        break;
    }

    throw new Exception();
  }
}
