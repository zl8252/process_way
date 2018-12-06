import 'dart:async';
import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_group_shared.dart';

class GroupTemplateBloc extends GroupShared implements IComponentTemplateBloc {
  GroupTemplateBloc({
    bool isExpanded = true,
    @required GroupMold mold,
    @required List<IComponentTemplateBloc> items,
  })  : assert(items != null),
        _items = items,
        super(mold: mold) {
    _inMoveItemSubject.listen(_onInMoveItem);
    _inAddComponentAtBackSubject.listen(_onInAddComponentAtBack);
    _inRemoveAllItemsSubject.listen(_onInRemoveAllItems);
    _inRemoveItemSubject.listen(_onInRemoveItem);
    _inCreateInstanceSubject.listen(_onInCreateInstance);

    _updateItemsStream();
  }

  List<IComponentTemplateBloc> _items;

  // output
  final _itemsSubject =
      new BehaviorSubject<UnmodifiableListView<IComponentTemplateBloc>>();

  ValueObservable<UnmodifiableListView<IComponentTemplateBloc>> get items =>
      _itemsSubject;

  // input
  final _inMoveItemSubject = new PublishSubject<MoveItemRequest>();
  final _inAddComponentAtBackSubject =
      new PublishSubject<IComponentTemplateBloc>();
  final _inRemoveAllItemsSubject = new PublishSubject<Null>();
  final _inRemoveItemSubject = new PublishSubject<IComponentTemplateBloc>();
  final _inCreateInstanceSubject =
      new PublishSubject<Completer<GroupInstance>>();

  Sink<MoveItemRequest> get inMoveItem => _inMoveItemSubject;

  Sink<IComponentTemplateBloc> get inAddComponentAtBack =>
      _inAddComponentAtBackSubject;

  Sink<Null> get inRemoveAllItems => _inRemoveAllItemsSubject;

  Sink<IComponentTemplateBloc> get inRemoveItem => _inRemoveItemSubject;

  @override
  Sink<Completer<GroupInstance>> get inCreateInstance =>
      _inCreateInstanceSubject;

  // input handling
  Future _onInMoveItem(MoveItemRequest request) async {
    if (!_items.contains(request.item)) return;

    int oldIndex = _items.indexOf(request.item);
    int newIndex;
    switch (request.direction) {
      case MoveItemDirection.up:
        newIndex = oldIndex - 1;
        break;
      case MoveItemDirection.down:
        newIndex = oldIndex + 1;
        break;
    }

    _items.remove(request.item);
    newIndex = newIndex.clamp(0, _items.length);
    _items.insert(newIndex, request.item);

    _updateItemsStream();
  }

  Future _onInAddComponentAtBack(IComponentTemplateBloc data) async {
    _items.add(data);

    _updateItemsStream();
  }

  Future _onInRemoveAllItems(_) async {
    _items.clear();

    _updateItemsStream();
  }

  Future _onInRemoveItem(IComponentTemplateBloc item) async {
    _items.remove(item);

    _updateItemsStream();
  }

  Future _onInCreateInstance(Completer<GroupInstance> completer) async {
    GroupInstance instance = new GroupInstance(
      mold: mold,
      cast: mold.createCast(),
      items: await Future.wait(_items.map(
        (item) {
          Completer<IComponentInstance> c = new Completer();
          item.inCreateInstance.add(c);
          return c.future;
        },
      ).toList()),
    );

    completer.complete(instance);
  }

  // --
  void _updateItemsStream() {
    _itemsSubject.add(new UnmodifiableListView(_items));
  }

  @override
  void dispose() {
    super.dispose();

    _items.forEach((item) => item.dispose());

    _itemsSubject.close();

    _inMoveItemSubject.close();
    _inAddComponentAtBackSubject.close();
    _inRemoveAllItemsSubject.close();
    _inRemoveItemSubject.close();
    _inCreateInstanceSubject.close();
  }
}
