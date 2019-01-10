import 'package:flutter/material.dart';

import 'package:rx_widgets/rx_widgets.dart';
import 'package:process_way/process_way.dart';

class InstanceListItem extends StatefulWidget {
  InstanceListItem({
    Key key,
    @required this.bloc,
    @required this.onRun,
    @required this.onDelete,
    @required this.onExport,
    @required this.onMoveUp,
    @required this.onMoveDown,
  })  : assert(bloc != null),
        assert(onRun != null),
        assert(onDelete != null),
        assert(onExport != null),
        assert(onMoveUp != null),
        assert(onMoveDown != null),
        super(key: key);

  final InstanceBloc bloc;

  final VoidCallback onRun;
  final VoidCallback onDelete;
  final VoidCallback onExport;

  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  _InstanceListItemState createState() => _InstanceListItemState();
}

class _InstanceListItemState extends State<InstanceListItem> {
  bool _isExpanded;

  @override
  void initState() {
    super.initState();

    _isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: new Card(
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
                    onPressed: widget.onRun,
                  ),
                  new Expanded(
                    child: new Center(
                      child: new RxText(
                        widget.bloc.instanceName,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ),
                  new IconButton(
                    icon: new Icon(Icons.expand_less),
                    onPressed: widget.onMoveUp,
                  ),
                  new IconButton(
                    icon: new Icon(Icons.expand_more),
                    onPressed: widget.onMoveDown,
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
                        stream: widget.bloc.isCompleted,
                        sink: null,
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 2,
                    child: new Container(
                      color: Theme.of(context).cardColor,
                      constraints: new BoxConstraints.expand(),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text("template:"),
                          new RxText(
                            widget.bloc.title,
                            style: Theme.of(context).textTheme.subtitle,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return new Material(
      color: Colors.red[200],
      child: new AnimatedContainer(
        padding: new EdgeInsets.only(left: 8, right: 4),
        duration: new Duration(milliseconds: 200),
        height: _isExpanded ? 50.0 : 0.0,
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new FlatButton(
              child: new Text("Export"),
              onPressed: widget.onExport,
            ),
            new Expanded(child: new Container()),
            new IconButton(
              icon: new Icon(Icons.clear),
              onPressed: widget.onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
