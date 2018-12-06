import 'package:flutter/material.dart';

import 'package:process_way/process_way.dart';

class ComponentTypePickerDialog extends StatelessWidget {
  ComponentTypePickerDialog({
    @required this.onComponentTypePicked,
  }) : assert(onComponentTypePicked != null);

  final ValueChanged<ComponentType> onComponentTypePicked;

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text("Pick Component Type"),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new ListTile(
            title: new Text(
              Strings.componentTypeToString(ComponentType.checkboxComponent),
            ),
            onTap: () => onComponentTypePicked(ComponentType.checkboxComponent),
          ),
          new ListTile(
            title: new Text(
              Strings.componentTypeToString(ComponentType.groupComponent),
            ),
            onTap: () => onComponentTypePicked(ComponentType.groupComponent),
          )
        ],
      ),
    );
  }
}
