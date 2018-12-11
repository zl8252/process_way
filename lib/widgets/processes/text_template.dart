import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rx_widgets/rx_widgets.dart';

import 'package:process_way/process_way.dart';

class TextTemplate extends StatelessWidget {
  TextTemplate({
    @required this.bloc,
  }) : assert(bloc != null);

  final TextTemplateBloc bloc;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: new RxEditableText(
              stream: bloc.text,
              sink: bloc.inText,
            ),
          ),
          new Container(
            color: Colors.grey[200],
            width: double.infinity,
            alignment: Alignment.centerRight,
            padding: new EdgeInsets.only(right: 8),
            child: new Text("Supports Markdown"),
          )
        ],
      ),
    );
  }
}
