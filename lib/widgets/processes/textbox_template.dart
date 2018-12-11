import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rx_widgets/rx_widgets.dart';

import 'package:process_way/process_way.dart';

class TextBoxTemplate extends StatelessWidget {
  TextBoxTemplate({
    @required this.bloc,
  }) : assert(bloc != null);

  final TextBoxTemplateBloc bloc;

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
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text("Hint"),
                new RxEditableText.optional(
                  optionalStream: bloc.hint,
                  optionalSink: bloc.inHint,
                  decoration: new InputDecoration.collapsed(hintText: "__"),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ],
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
              stream: bloc.title,
              sink: bloc.inTitle,
              style: Theme.of(context).textTheme.title,
              decoration: new InputDecoration.collapsed(hintText: "Title"),
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}
