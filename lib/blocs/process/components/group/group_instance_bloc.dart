import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_group_shared.dart';

class GroupInstanceBloc extends GroupShared implements IComponentInstanceBloc {
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
  void dispose() {
    super.dispose();

    _items.forEach((item) => item.dispose());
  }
}
