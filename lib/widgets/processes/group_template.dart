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
        ),
      );
    }

    columnItems.add(
      new StreamBuilder<bool>(
        initialData: widget.bloc.isExpanded.value,
        stream: widget.bloc.isExpanded,
        builder: (context, snapshot) {
          if (snapshot.data) {
            return new _GroupTemplateItems(
              bloc: widget.bloc,
              onAddItem: _addNewItemAtBack,
            );
          } else {
            return new Container();
          }
        },
      ),
    );

    return new Column(
      children: columnItems,
    );
  }
}

class _GroupTemplateInfo extends StatelessWidget {
  _GroupTemplateInfo({
    @required this.bloc,
  }) : assert(bloc != null);

  final GroupTemplateBloc bloc;

  void _toggleExpansion() {
    bloc.inToggleIsExpanded.add(null);
  }

  void _clearAllItems() {
    bloc.inRemoveAllItems.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.grey[200],
      child: Container(
        padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: new Row(
          children: <Widget>[
            new StreamBuilder<bool>(
              initialData: bloc.isExpanded.value,
              stream: bloc.isExpanded,
              builder: (context, snapshot) {
                return new IconButton(
                  icon: new Icon(snapshot.data
                      ? Icons.remove_circle_outline
                      : Icons.add_circle_outline),
                  onPressed: _toggleExpansion,
                );
              },
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
              onPressed: _clearAllItems,
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupTemplateItems extends StatelessWidget {
  _GroupTemplateItems({
    @required this.bloc,
    @required this.onAddItem,
  })  : assert(bloc != null),
        assert(onAddItem != null);

  final GroupTemplateBloc bloc;
  final VoidCallback onAddItem;

  void _removeItem(IComponentTemplateBloc item) {
    bloc.inRemoveItem.add(item);
  }

  void _moveItem(IComponentTemplateBloc item, MoveItemDirection direction) {
    bloc.inMoveItem.add(
      new MoveItemRequest(
        item: item,
        direction: direction,
      ),
    );
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
                onRemoveItem: () => _removeItem(item),
                onMoveItemUp: () => _moveItem(item, MoveItemDirection.up),
                onMoveItemDown: () => _moveItem(item, MoveItemDirection.down),
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
    @required this.onMoveItemUp,
    @required this.onMoveItemDown,
    @required this.onRemoveItem,
  })  : assert(componentType != null),
        assert(onMoveItemUp != null),
        assert(onMoveItemDown != null),
        assert(onRemoveItem != null);

  final ComponentType componentType;
  final VoidCallback onMoveItemUp;
  final VoidCallback onMoveItemDown;
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
            icon: new Icon(Icons.expand_less),
            onPressed: onMoveItemUp,
          ),
          new IconButton(
            icon: new Icon(Icons.expand_more),
            onPressed: onMoveItemDown,
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
