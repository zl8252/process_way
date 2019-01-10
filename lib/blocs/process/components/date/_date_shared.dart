import 'dart:async';

import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

abstract class DateShared extends ComponentBloc {
  DateShared({
    @required this.mold,
  }) : assert(mold != null) {
    _inTitleSubject.listen(_onInTitle);
    _inCreateInstanceSubject.listen(_onInCreateInstance);

    _updateTitleStream();
  }

  @protected
  DateMold mold;

  @override
  ComponentType get type => ComponentType.dateComponent;

  // output
  final _titleSubject = new BehaviorSubject<String>();

  ValueObservable<String> get title => _titleSubject;

  // input
  final _inTitleSubject = new PublishSubject<String>();
  final _inCreateInstanceSubject =
      new PublishSubject<Completer<IComponentInstanceBloc>>();

  Sink<String> get inTitle => _inTitleSubject;

  @override
  Sink<Completer<IComponentInstanceBloc>> get inCreateInstance =>
      _inCreateInstanceSubject;

  // input handling
  Future _onInTitle(String data) async {
    mold = mold.copyWith(title: data);

    _updateTitleStream();
  }

  Future _onInCreateInstance(Completer completer) async {
    var instance = new DateInstanceBloc(
      mold: mold,
      cast: mold.createCast(),
    );

    completer.complete(instance);
  }

  // --
  void _updateTitleStream() {
    _titleSubject.add(mold.title);
  }

  @override
  void dispose() {
    super.dispose();

    _titleSubject.close();

    _inTitleSubject.close();
    _inCreateInstanceSubject.close();
  }
}
