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
      content: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new ListTile(
              title: new Text(
                Strings.componentTypeToString(ComponentType.checkboxComponent),
              ),
              onTap: () =>
                  onComponentTypePicked(ComponentType.checkboxComponent),
            ),
            new ListTile(
              title: new Text(
                  Strings.componentTypeToString(ComponentType.dateComponent)),
              onTap: () => onComponentTypePicked(ComponentType.dateComponent),
            ),
            new ListTile(
              title: new Text(
                  Strings.componentTypeToString(ComponentType.groupComponent)),
              onTap: () => onComponentTypePicked(ComponentType.groupComponent),
            ),
            new ListTile(
              title:
                  new Text(Strings.componentTypeToString(ComponentType.number)),
              onTap: () => onComponentTypePicked(ComponentType.number),
            ),
            new ListTile(
              title: new Text(
                Strings.componentTypeToString(ComponentType.text),
              ),
              onTap: () => onComponentTypePicked(ComponentType.text),
            ),
            new ListTile(
              title: new Text(
                  Strings.componentTypeToString(ComponentType.textBox)),
              onTap: () => onComponentTypePicked(ComponentType.textBox),
            ),
          ],
        ),
      ),
    );
  }
}
