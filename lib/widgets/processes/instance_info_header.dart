import 'package:flutter/material.dart';
import 'package:rx_widgets/rx_widgets.dart';

import 'package:process_way/process_way.dart';

class InstanceInfoHeader extends StatelessWidget {
  InstanceInfoHeader({
    @required this.bloc,
  }) : assert(bloc != null);

  final InstanceBloc bloc;

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.grey[200],
      elevation: 3,
      child: new Container(
        padding: new EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: new Row(
          children: <Widget>[
            new RxCheckbox(
              stream: bloc.isCompleted,
              sink: bloc.inIsCompleted,
            ),
            new Expanded(
              child: new Column(
                children: <Widget>[
                  new RxEditableText(
                    stream: bloc.instanceName,
                    sink: bloc.inInstanceName,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.title,
                  ),
                  new Row(children: <Widget>[
                    new Text("Instance of: "),
                    new RxText(bloc.title),
                  ],)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
