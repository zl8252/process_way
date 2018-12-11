import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:rx_widgets/rx_widgets.dart';
import 'package:process_way/process_way.dart';

class GroupInstance extends StatelessWidget {
  GroupInstance({
    @required this.bloc,
    this.showHeader = true,
  })  : assert(bloc != null),
        assert(showHeader != null);

  final GroupInstanceBloc bloc;
  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = <Widget>[];

    if (showHeader) {
      columnChildren.add(new _GroupInstanceHeader(
        bloc: bloc,
      ));
    }

    columnChildren.add(
      new StreamBuilder<bool>(
        initialData: bloc.isExpanded.value,
        stream: bloc.isExpanded,
        builder: (context, snapshot) {
          if (!snapshot.data) return new Container();

          return new _GroupInstanceItems(
            bloc: bloc,
            padLeft: showHeader,
          );
        },
      ),
    );

    return Container(
      child: new Column(
        children: columnChildren,
      ),
    );
  }
}

class _GroupInstanceHeader extends StatelessWidget {
  _GroupInstanceHeader({
    @required this.bloc,
  }) : assert(bloc != null);

  final GroupInstanceBloc bloc;

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.grey[200],
      child: new ListTile(
        leading: new StreamBuilder<bool>(
          initialData: bloc.isExpanded.value,
          stream: bloc.isExpanded,
          builder: (context, snapshot) {
            return new IconButton(
              icon: new Icon(snapshot.data
                  ? Icons.remove_circle_outline
                  : Icons.add_circle_outline),
              onPressed: () => bloc.inToggleIsExpanded.add(null),
            );
          },
        ),
        title: new RxText(
          bloc.title,
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }
}

class _GroupInstanceItems extends StatelessWidget {
  _GroupInstanceItems({
    @required this.bloc,
    this.padLeft = true,
  })  : assert(bloc != null),
        assert(padLeft != null);

  final GroupInstanceBloc bloc;

  final bool padLeft;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(
          width: padLeft ? 16 : 0,
        ),
        new Expanded(
          child: _buildItems(),
        ),
      ],
    );
  }

  Widget _buildItems() {
    return new StreamBuilder<UnmodifiableListView<IComponentInstanceBloc>>(
      initialData: bloc.items.value,
      stream: bloc.items,
      builder: (context, snapshot) {
        return new Column(
          children: snapshot.data
              .map(
                (item) => new ComponentInstance(
                      key: new ObjectKey(item),
                      bloc: item,
                    ),
              )
              .toList(),
        );
      },
    );
  }
}
