import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

abstract class GroupShared extends ComponentBloc {
  GroupShared({
    @required this.mold,
  }) : assert(mold != null) {
    _inTitleSubject.listen(_onInTitle);

    _updateTitleStream();
  }

  @protected
  GroupMold mold;

  @override
  ComponentType get type => ComponentType.groupComponent;

  // output
  final _titleSubject = new BehaviorSubject<String>();

  ValueObservable<String> get title => _titleSubject;

  // input
  final _inTitleSubject = new PublishSubject<String>();

  Sink<String> get inTitle => _inTitleSubject;

  // input handling
  Future _onInTitle(String data) async {
    mold = mold.copyWith(title: data);

    _updateTitleStream();
  }

  // --
  void _updateTitleStream() {
    _titleSubject.add(mold.title);
  }

  @override
  @mustCallSuper
  void dispose() {
    _titleSubject.close();

    _inTitleSubject.close();
  }
}
