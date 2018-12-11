import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rx_widgets/rx_widgets.dart';

import 'package:process_way/process_way.dart';

class NumberTemplate extends StatelessWidget {
  NumberTemplate({
    @required this.bloc,
  }) : assert(bloc != null);

  final NumberTemplateBloc bloc;

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          flex: 1,
          child: new Container(
            color: Colors.grey[200],
            height: 70,
            alignment: Alignment.center,
            child: new Text(
              "___",
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        new Expanded(
          flex: 2,
          child: new Container(
            padding: new EdgeInsets.symmetric(horizontal: 8),
            height: 70,
            alignment: Alignment.centerLeft,
            child: new RxEditableText(
              stream: bloc.label,
              sink: bloc.inLabel,
              style: Theme.of(context).textTheme.title,
              decoration: new InputDecoration.collapsed(hintText: "Label"),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}
