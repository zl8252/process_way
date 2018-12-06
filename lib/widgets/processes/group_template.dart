import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:process_way/process_way.dart';

class GroupTemplate extends StatefulWidget {
  GroupTemplate({
    @required this.bloc,
    this.showGroupInfo = true,
  })  : assert(bloc != null),
        assert(showGroupInfo != null);

  final bool showGroupInfo;
  final GroupTemplateBloc bloc;

  @override
  _GroupTemplateState createState() => _GroupTemplateState();
}

class _GroupTemplateState extends State<GroupTemplate> {
  bool _isExpanded;

  @override
  void initState() {
    super.initState();

    _isExpanded = true;
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _clearAllItems() {
    widget.bloc.inRemoveAllItems.add(null);
  }

  void _addNewItemAtBack() {
    BlocProvider.of<DesigningScreenBloc>(context)
        .inAddNewItemToGroup
        .add(new AddNewItemToGroupRequest(
          group: widget.bloc,
        ));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> columnItems = <Widget>[];

    if (widget.showGroupInfo) {
      columnItems.add(
        new _GroupTemplateInfo(
          bloc: widget.bloc,
          isExpanded: _isExpanded,
          onToggleExpansion: _toggleExpansion,
          onClearAllItems: _clearAllItems,
        ),
      );
    }

    if (_isExpanded) {
      columnItems.add(
        new _GroupTemplateItems(
          bloc: widget.bloc,
          onAddItem: _addNewItemAtBack,
        ),
      );
    }

    return new Column(
      children: columnItems,
    );
  }
}

class _GroupTemplateInfo extends StatelessWidget {
  _GroupTemplateInfo({
    @required this.bloc,
    @required this.isExpanded,
    @required this.onToggleExpansion,
    @required this.onClearAllItems,
  })  : assert(bloc != null),
        assert(isExpanded != null),
        assert(onToggleExpansion != null),
        assert(onClearAllItems != null);

  final GroupTemplateBloc bloc;

  final bool isExpanded;
  final VoidCallback onToggleExpansion;
  final VoidCallback onClearAllItems;

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.grey[200],
      child: Container(
        padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: new Row(
          children: <Widget>[
            new IconButton(
              icon: new Icon(isExpanded
                  ? Icons.remove_circle_outline
                  : Icons.add_circle_outline),
              onPressed: onToggleExpansion,
            ),
            new Expanded(
              child: new RxEditableText(
                stream: bloc.title,
                sink: bloc.inTitle,
                style: Theme.of(context).textTheme.title,
                decoration:
                    new InputDecoration.collapsed(hintText: "Group Name"),
                maxLines: 1,
              ),
            ),
            new IconButton(
              icon: new Icon(Icons.clear_all),
              onPressed: onClearAllItems,
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupTemplateItems extends StatelessWidget {
  _GroupTemplateItems({@required this.bloc, @required this.onAddItem})
      : assert(bloc != null),
        assert(onAddItem != null);

  final GroupTemplateBloc bloc;
  final VoidCallback onAddItem;

  void _onRemoveItem(IComponentTemplateBloc item) {
    bloc.inRemoveItem.add(item);
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<UnmodifiableListView<IComponentTemplateBloc>>(
      stream: bloc.items,
      initialData: bloc.items.value,
      builder: (context, snapshot) {
        return Container(
          child: new IntrinsicHeight(
            child: new Row(
              children: <Widget>[
                _buildIndicationLine(),
                new Expanded(
                  child: _buildItemsColumn(snapshot.data),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIndicationLine() {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 8),
      child: new Container(
        width: 2,
        height: double.infinity,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildItemsColumn(UnmodifiableListView<IComponentTemplateBloc> items) {
    List<Widget> columnChildren = <Widget>[
      new _ItemSeparator(),
    ];
    items.map<Widget>(
      (item) {
        columnChildren.add(
          new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new _GroupItemHeader(
                componentType: item.type,
                onRemoveItem: () => _onRemoveItem(item),
              ),
              new ComponentTemplate(
                bloc: item,
              ),
              new _ItemSeparator(),
            ],
          ),
        );
      },
    ).toList();

    columnChildren.add(
      _buildAddItemButton(),
    );

    return new Column(
      children: columnChildren,
    );
  }

  Widget _buildAddItemButton() {
    return new FlatButton.icon(
      icon: new Icon(Icons.add),
      label: new Text("Add"),
      onPressed: onAddItem,
      color: Colors.grey[200],
    );
  }
}

class _GroupItemHeader extends StatelessWidget {
  _GroupItemHeader({
    @required this.componentType,
    @required this.onRemoveItem,
  })  : assert(componentType != null),
        assert(onRemoveItem != null);

  final ComponentType componentType;
  final VoidCallback onRemoveItem;

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.grey[300],
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
              padding: new EdgeInsets.only(left: 16),
              child: new Text(
                Strings.componentTypeToString(componentType),
                style: Theme.of(context).textTheme.subtitle,
              ),
            ),
          ),
          new IconButton(
            icon: new Icon(Icons.clear),
            onPressed: onRemoveItem,
          ),
        ],
      ),
    );
  }
}

class _ItemSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 8.0,
      width: 2.0,
      color: Colors.grey,
    );
  }
}
