import 'dart:async';

import 'package:flutter/material.dart';

import 'package:process_way/process_way.dart';

class DesigningScreen extends StatefulWidget {
  DesigningScreen({
    @required this.templateId,
  }) : assert(templateId != null);

  final int templateId;

  @override
  _DesigningScreenState createState() => _DesigningScreenState();
}

class _DesigningScreenState extends State<DesigningScreen> {
  DesigningScreenBloc _designingScreenBloc;

  @override
  void dispose() {
    _designingScreenBloc.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_designingScreenBloc == null) {
      _designingScreenBloc = new DesigningScreenBloc(
        templateId: widget.templateId,
        processesBloc: BlocProvider.of<ProcessesBloc>(context),
        processCreationBloc: BlocProvider.of<ProcessCreationBloc>(context),
      );

      _designingScreenBloc.outPickComponentType.listen(_onPickComponentType);
    }
  }

  Future _onPickComponentType(PickComponentTypeInvoke invoke) async {
    Completer<ComponentType> completer = new Completer();

    await showDialog<ComponentType>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return new ComponentTypePickerDialog(
            onComponentTypePicked: (componentType) {
              Navigator.of(context).pop();
              completer.complete(componentType);
            },
          );
        });

    ComponentType componentType = await completer.future;

    invoke.completer.complete(componentType);
  }

  @override
  Widget build(BuildContext context) {
    return new BlocProvider<DesigningScreenBloc>(
      bloc: _designingScreenBloc,
      child: new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          title: new Text("Template Designer"),
        ),
        body: new StreamBuilder<TemplateBloc>(
          stream: _designingScreenBloc.template,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return new Container();

            return new Column(
              children: <Widget>[
                new TemplateInfoHeader(
                  template: snapshot.data,
                ),
                new Expanded(
                  child: new SingleChildScrollView(
                    child: new GroupTemplate(
                      bloc: snapshot.data.rootGroup.value,
                      showGroupInfo: false,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
