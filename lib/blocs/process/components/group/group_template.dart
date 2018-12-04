import 'dart:async';
import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

import '_group_shared.dart';

class GroupTemplate extends GroupShared implements IComponentTemplate {
  GroupTemplate({
    @required GroupMold mold,
    @required List<IComponentTemplate> items,
  })  : assert(items != null),
        _items = items,
        super(mold: mold) {
    _inAddComponentAtBackSubject.listen(_onInAddComponentAtBack);
    _inRemoveAllComponentsSubject.listen(_onInRemoveAllComponents);
    _inCreateInstanceSubject.listen(_onInCreateInstance);

    _updateItemsStream();
  }

  List<IComponentTemplate> _items;

  // output
  final _itemsSubject =
      new BehaviorSubject<UnmodifiableListView<IComponentTemplate>>();

  ValueObservable<UnmodifiableListView<IComponentTemplate>> get items =>
      _itemsSubject;

  // input
  final _inAddComponentAtBackSubject = new PublishSubject<IComponentTemplate>();
  final _inRemoveAllComponentsSubject = new PublishSubject<Null>();
  final _inCreateInstanceSubject =
      new PublishSubject<Completer<GroupInstance>>();

  Sink<IComponentTemplate> get inAddComponentAtBack => _inAddComponentAtBackSubject;

  Sink<Null> get inRemoveAllComponents => _inRemoveAllComponentsSubject;

  @override
  Sink<Completer<GroupInstance>> get inCreateInstance =>
      _inCreateInstanceSubject;

  // input handling
  Future _onInAddComponentAtBack(IComponentTemplate data) async {
    _items.add(data);

    _updateItemsStream();
  }

  Future _onInRemoveAllComponents(_) async {
    _items.clear();

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

    _inAddComponentAtBackSubject.close();
    _inRemoveAllComponentsSubject.close();
    _inCreateInstanceSubject.close();
  }
}
