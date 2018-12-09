import 'package:flutter/material.dart';

import 'package:rx_widgets/rx_widgets.dart';
import 'package:process_way/process_way.dart';

class InstanceListItem extends StatelessWidget {
  InstanceListItem({
    Key key,
    @required this.bloc,
    @required this.onRun,
    @required this.onDelete,
  })  : assert(bloc != null),
        assert(onRun != null),
        assert(onDelete != null),
        super(key: key);

  final InstanceBloc bloc;
  final VoidCallback onRun;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 2,
      color: Colors.grey[300],
      clipBehavior: Clip.antiAlias,
      child: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.symmetric(vertical: 8),
            child: new Row(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.play_arrow),
                  onPressed: onRun,
                ),
                new Expanded(
                  child: new Center(
                    child: new RxText(
                      bloc.instanceName,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                ),
                new IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
          new IntrinsicHeight(
            child: new Row(
              children: <Widget>[
                new Expanded(
                  flex: 1,
                  child: new Container(
                    color: Colors.grey[200],
                    child: new RxCheckbox(
                      stream: bloc.isCompleted,
                      sink: null,
                    ),
                  ),
                ),
                new Expanded(
                  flex: 2,
                  child: new Container(
                    color: Theme.of(context).cardColor,
                    constraints: new BoxConstraints.expand(),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new RxText(
                          bloc.title,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        new RxOptionalText(bloc.details),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
