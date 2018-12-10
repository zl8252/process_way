import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:process_way/process_way.dart';

class TemplatesTab extends StatefulWidget {
  @override
  _TemplatesTabState createState() => _TemplatesTabState();
}

class _TemplatesTabState extends State<TemplatesTab>
    with AutomaticKeepAliveClientMixin {
  TemplatesScreenBloc _templatesScreenBloc;

  ProcessesBloc get _processesBloc => BlocProvider.of<ProcessesBloc>(context);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _templatesScreenBloc = new TemplatesScreenBloc();

    _templatesScreenBloc.outShowDesignerScreen.listen(_onShowDesignerScreen);
  }

  @override
  void dispose() {
    _templatesScreenBloc.dispose();
    super.dispose();
  }

  void _onShowDesignerScreen(ShowDesignerScreenInvoke invoke) {
    print("Starting designer for template:${invoke.templateId}");

    Navigator.of(context).push(
      new MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return new DesigningScreen(
            templateId: invoke.templateId,
          );
        },
      ),
    );
  }

  void _createInstanceFromTemplate(int templateId) {
    _processesBloc.inCreateInstanceFromTemplate.add(templateId);
  }

  void _designTemplate(int templateId) {
    _templatesScreenBloc.inStartDesigning.add(
      new StartDesigningRequest(templateId: templateId),
    );
  }

  void _deleteTemplate(int templateId) {
    _processesBloc.inDeleteTemplate.add(templateId);
  }

  void _createNewTemplate() {
    _processesBloc.inCreateNewTemplate.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new StreamBuilder<UnmodifiableListView<TemplateBloc>>(
          initialData: new UnmodifiableListView([]),
          stream: _processesBloc.templates,
          builder: (context, snapshot) {
            if (snapshot.data.length == 0) {
              return new Center(
                child: new Text(
                  "No Tenplates",
                  style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return new ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                TemplateBloc template = snapshot.data[index];

                return new TemplateListItem(
                  key: new ObjectKey(template),
                  template: template,
                  onCreateInstance: () =>
                      _createInstanceFromTemplate(template.id),
                  onDesign: () => _designTemplate(template.id),
                  onDelete: () => _deleteTemplate(template.id),
                );
              },
            );
          },
        ),
        new Positioned(
          bottom: kFloatingActionButtonMargin,
          right: kFloatingActionButtonMargin,
          child: new FloatingActionButton(
            child: new Icon(Icons.add),
            onPressed: _createNewTemplate,
          ),
        ),
      ],
    );
  }
}
