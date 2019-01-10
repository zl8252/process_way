import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rx_widgets/rx_widgets.dart';
import 'package:quiver/core.dart';

import 'package:process_way/process_way.dart';

class NumberInstance extends StatelessWidget {
  NumberInstance({
    @required this.bloc,
  }) : assert(bloc != null);

  final NumberInstanceBloc bloc;

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: new RxText(bloc.label),
      trailing: new Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            width: 50,
            child: new RxEditableNumber(
              stream: bloc.value,
              sink: bloc.inValue,
              decoration: new InputDecoration.collapsed(
                  hintText: "number", border: new UnderlineInputBorder()),
            ),
          ),
          new IconButton(
            icon: new Icon(Icons.clear),
            onPressed: () {
              bloc.inValue.add(new Optional.absent());
            },
          ),
        ],
      ),
    );
  }
}
