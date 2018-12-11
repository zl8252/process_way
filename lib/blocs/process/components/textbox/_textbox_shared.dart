import 'dart:async';

import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

abstract class TextBoxShared extends ComponentBloc {
  TextBoxShared({
    @required this.mold,
  }) : assert(mold != null) {
    _inTitleSubject.listen(_onInTitle);
    _inHintSubject.listen(_onInHint);

    _updateTitleStream();
    _updateHintStream();
  }

  @protected
  TextBoxMold mold;

  @override
  ComponentType get type => ComponentType.textBox;

  final _titleSubject = new BehaviorSubject<String>();
  final _hintSubject = new BehaviorSubject<Optional<String>>();

  ValueObservable<String> get title => _titleSubject;

  ValueObservable<Optional<String>> get hint => _hintSubject;

  final _inTitleSubject = new PublishSubject<String>();
  final _inHintSubject = new PublishSubject<Optional<String>>();

  Sink<String> get inTitle => _inTitleSubject;

  Sink<Optional<String>> get inHint => _inHintSubject;

  Future _onInTitle(String data) async {
    mold = mold.copyWith(title: data);

    _updateTitleStream();
  }

  Future _onInHint(Optional<String> data) async {
    mold = mold.copyWith(hint: data);

    _updateHintStream();
  }

  void _updateTitleStream() {
    _titleSubject.add(mold.title);
  }

  void _updateHintStream() {
    _hintSubject.add(mold.hint);
  }

  @override
  void dispose() {
    super.dispose();

    _titleSubject.close();
    _hintSubject.close();

    _inTitleSubject.close();
    _inHintSubject.close();
  }
}
