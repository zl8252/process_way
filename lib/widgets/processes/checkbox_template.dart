import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class CheckboxTemplate extends StatelessWidget {
  CheckboxTemplate({
    @required this.bloc,
  }) : assert(bloc != null);

  final CheckboxTemplateBloc bloc;

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(
              color: Colors.grey[200],
              child: new Column(
                children: <Widget>[
                  new Text("Initial Value"),
                  new RxCheckbox(
                    stream: bloc.initialValue,
                    sink: bloc.inInitialValue,
                  ),
                ],
              ),
            ),
          ),
          new Expanded(
            flex: 2,
            child: new Container(
              padding: new EdgeInsets.symmetric(horizontal: 8),
              child: new Column(
                children: <Widget>[
                  new RxEditableText(
                    stream: bloc.title,
                    sink: bloc.inTitle,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.title,
                    decoration:
                        new InputDecoration.collapsed(hintText: "Title"),
                  ),
                  new RxEditableText.optional(
                    optionalStream: bloc.subtitle,
                    optionalSink: bloc.inSubtitle,
                    maxLines: 1,
                    decoration: new InputDecoration.collapsed(hintText: "Subtitle"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
