import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:process_way/process_way.dart';

class TemplatesTab extends StatefulWidget {
  @override
  _TemplatesTabState createState() => _TemplatesTabState();
}

class _TemplatesTabState extends State<TemplatesTab>
    with AutomaticKeepAliveClientMixin {
  ProcessesBloc get _processesBloc => BlocProvider.of<ProcessesBloc>(context);

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    void _onCreateNewTemplate() {
      _processesBloc.inCreateNewTemplate.add(null);
    }

    void _onDeleteTemplate(TemplateBloc template) {
      _processesBloc.inDeleteTemplate.add(template.id);
    }

    return new Stack(
      children: <Widget>[
        new StreamBuilder<UnmodifiableListView<TemplateBloc>>(
          initialData: new UnmodifiableListView([]),
          stream: _processesBloc.templates,
          builder: (context, snapshot) {
            return new ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                TemplateBloc template = snapshot.data[index];

                return new TemplateListItem(
                  key: new ObjectKey(template),
                  template: template,
                  onCreateInstance: () {},
                  onEdit: () {},
                  onDelete: () {
                    _onDeleteTemplate(template);
                  },
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
            onPressed: _onCreateNewTemplate,
          ),
        ),
      ],
    );
  }
}
