import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:rx_widgets/rx_widgets.dart';

import 'package:process_way/process_way.dart';

class TextBoxInstance extends StatelessWidget {
  TextBoxInstance({
    @required this.bloc,
  }) : assert(bloc != null);

  final TextBoxInstanceBloc bloc;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new RxText(bloc.title),
      trailing: new Container(
        width: 250,
        child: new StreamBuilder<Optional<String>>(
          initialData: bloc.hint.value,
          stream: bloc.hint,
          builder: (context, snapshot) {
            return new RxEditableText(
              stream: bloc.text,
              sink: bloc.inText,
              decoration: new InputDecoration.collapsed(
                hintText: snapshot.data.or(""),
                border: new UnderlineInputBorder(),
              ),
              maxLines: 1,
            );
          },
        ),
      ),
    );
  }
}
