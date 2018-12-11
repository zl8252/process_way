import 'dart:async';
import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_group_shared.dart';

class GroupInstanceBloc extends GroupShared implements IComponentInstanceBloc {
  static const _key_mold = "mold";
  static const _key_cast = "cast";
  static const _key_items = "items";

  GroupInstanceBloc({
    @required GroupMold mold,
    @required GroupCast cast,
    @required List<IComponentInstanceBloc> items,
  })  : assert(cast != null),
        assert(items != null),
        _cast = cast,
        _items = items,
        super(mold: mold) {
    _updateItemsStream();
  }

  static GroupInstanceBloc fromMap(Map map) {
    return   new GroupInstanceBloc(
      mold: new GroupMold.fromMap(map[_key_mold]),
      cast: new GroupCast.fromMap(map[_key_cast]),
      items: map[_key_items].map<IComponentInstanceBloc>((itemMap) {
        ComponentBloc component = ComponentBloc.fromMap(itemMap);
        return component as IComponentInstanceBloc;
      }).toList(),
    );
  }

  GroupCast _cast;

  List<IComponentInstanceBloc> _items;

  // output
  final _itemsSubject =
      new BehaviorSubject<UnmodifiableListView<IComponentInstanceBloc>>();

  ValueObservable<UnmodifiableListView<IComponentInstanceBloc>> get items =>
      _itemsSubject;

  // --
  void _updateItemsStream() {
    _itemsSubject.add(new UnmodifiableListView(_items));
  }

  @override
  Future<Map> toMap() async {
    List<Future<Map>> itemsMapsFutures = [];
    for (final item in _items) {
      Completer<Map> completer = new Completer();

      item.inToMap.add(completer);
      itemsMapsFutures.add(completer.future);
    }

    return <String, dynamic>{
      "bloc": "GroupInstanceBloc",
      _key_mold: mold.toMap(),
      _key_cast: _cast.toMap(),
      _key_items: await Future.wait<Map>(itemsMapsFutures),
    };
  }

  @override
  void dispose() {
    super.dispose();

    _items.forEach((item) => item.dispose());
  }
}
