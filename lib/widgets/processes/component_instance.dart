import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class ComponentInstance extends StatelessWidget {
  ComponentInstance({
    Key key,
    @required this.bloc,
  })  : assert(bloc != null),
        super(key: key);

  final IComponentInstanceBloc bloc;

  @override
  Widget build(BuildContext context) {
    switch (bloc.type) {
      case ComponentType.checkboxComponent:
        return new CheckboxInstance(bloc: bloc);
      case ComponentType.dateComponent:
        return new DateInstance(bloc: bloc);
      case ComponentType.groupComponent:
        return new GroupInstance(bloc: bloc);
      case ComponentType.number:
        return new NumberInstance(bloc: bloc);
      case ComponentType.text:
        return new TextInstance(bloc: bloc);
      case ComponentType.textBox:
        return new TextBoxInstance(bloc: bloc);
      case ComponentType.infoComponent:
        break;
    }

    throw new Exception();
  }
}
