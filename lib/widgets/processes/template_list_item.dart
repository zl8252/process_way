import 'package:flutter/material.dart';
import 'package:rx_widgets/rx_widgets.dart';

import 'package:process_way/process_way.dart';

class TemplateListItem extends StatefulWidget {
  TemplateListItem({
    Key key,
    @required this.template,
    @required this.onCreateInstance,
    @required this.onDesign,
    @required this.onDelete,
    @required this.onMoveUp,
    @required this.onMoveDown,
  })  : assert(template != null),
        assert(onCreateInstance != null),
        assert(onDesign != null),
        assert(onDelete != null),
        assert(onMoveUp != null),
        assert(onMoveDown != null),
        super(key: key);

  final TemplateBloc template;

  final VoidCallback onCreateInstance;
  final VoidCallback onDesign;
  final VoidCallback onDelete;

  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  _TemplateListItemState createState() => _TemplateListItemState();
}

class _TemplateListItemState extends State<TemplateListItem> {
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
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: new Column(
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              constraints: new BoxConstraints(minHeight: 50.0),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Expanded(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new RxText(
                              widget.template.title,
                              style: Theme.of(context).textTheme.title,
                            ),
                            new Expanded(child: new Container()),
                            new IconButton(
                              icon: new Icon(Icons.expand_less),
                              onPressed: widget.onMoveUp,
                            ),
                            new IconButton(
                              icon: Icon(Icons.expand_more),
                              onPressed: widget.onMoveDown,
                            ),
                          ],
                        ),
                        new RxOptionalText(widget.template.details),
                      ],
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
            new FlatButton.icon(
              icon: new Icon(Icons.play_arrow),
              label: new Text("Create Instance"),
              onPressed: widget.onCreateInstance,
            ),
            new Expanded(child: new Container()),
            new IconButton(
              icon: new Icon(
                Icons.edit,
              ),
              onPressed: widget.onDesign,
            ),
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
