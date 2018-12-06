import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

abstract class GroupShared extends ComponentBloc {
  GroupShared({
    bool isExpanded = true,
    @required this.mold,
  })  : assert(isExpanded != null),
        assert(mold != null),
        _isExpanded = isExpanded {
    _inToggleIsExpandedSubject.listen(_onInToggleIsExpanded);
    _inTitleSubject.listen(_onInTitle);

    _updateIsExpandedStream();
    _updateTitleStream();
  }

  @protected
  bool _isExpanded;

  @protected
  GroupMold mold;

  @override
  ComponentType get type => ComponentType.groupComponent;

  // output
  final _isExpandedSubject = new BehaviorSubject<bool>();
  final _titleSubject = new BehaviorSubject<String>();

  ValueObservable<bool> get isExpanded => _isExpandedSubject;

  ValueObservable<String> get title => _titleSubject;

  // input
  final _inToggleIsExpandedSubject = new PublishSubject<Null>();
  final _inTitleSubject = new PublishSubject<String>();

  Sink<Null> get inToggleIsExpanded => _inToggleIsExpandedSubject;

  Sink<String> get inTitle => _inTitleSubject;

  // input handling

  Future _onInToggleIsExpanded(_) async {
    _isExpanded = !_isExpanded;

    _updateIsExpandedStream();
  }

  Future _onInTitle(String data) async {
    mold = mold.copyWith(title: data);

    _updateTitleStream();
  }

  // --

  void _updateIsExpandedStream() {
    _isExpandedSubject.add(_isExpanded);
  }

  void _updateTitleStream() {
    _titleSubject.add(mold.title);
  }

  @override
  @mustCallSuper
  void dispose() {
    _isExpandedSubject.close();
    _titleSubject.close();

    _inToggleIsExpandedSubject.close();
    _inTitleSubject.close();
  }
}
