import 'dart:async';

import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

abstract class CheckboxShared extends ComponentBloc {
  CheckboxShared({
    @required this.mold,
  }) : assert(mold != null) {
    _inInitialValueSubject.listen(_onInInitialValue);
    _inTitleSubject.listen(_onInTitle);
    _inSubtitleSubject.listen(_onInSubtitle);
    _inCreateInstanceSubject.listen(_onInCreateInstance);

    _updateInitialValueStream();
    _updateTitleStream();
    _updateSubtitleStream();
  }

  @protected
  CheckboxMold mold;

  @override
  ComponentType get type => ComponentType.checkboxComponent;

  // output
  final _initialValueSubject = new BehaviorSubject<bool>();
  final _titleSubject = new BehaviorSubject<String>();
  final _subtitleSubject = new BehaviorSubject<Optional<String>>();

  ValueObservable<bool> get initialValue => _initialValueSubject;

  ValueObservable<String> get title => _titleSubject;

  ValueObservable<Optional<String>> get subtitle => _subtitleSubject;

  // input
  final _inInitialValueSubject = new PublishSubject<bool>();
  final _inTitleSubject = new PublishSubject<String>();
  final _inSubtitleSubject = new PublishSubject<Optional<String>>();
  final _inCreateInstanceSubject =
      new PublishSubject<Completer<IComponentInstanceBloc>>();

  Sink<bool> get inInitialValue => _inInitialValueSubject;

  Sink<String> get inTitle => _inTitleSubject;

  Sink<Optional<String>> get inSubtitle => _inSubtitleSubject;

  @override
  Sink<Completer<IComponentInstanceBloc>> get inCreateInstance =>
      _inCreateInstanceSubject;

  // input handling
  Future _onInInitialValue(bool data) async {
    mold = mold.copyWith(initialValue: data);

    _updateInitialValueStream();
  }

  Future _onInTitle(String data) async {
    mold = mold.copyWith(title: data);

    _updateTitleStream();
  }

  Future _onInSubtitle(Optional<String> data) async {
    mold = mold.copyWith(subtitle: data);

    _updateSubtitleStream();
  }

  Future _onInCreateInstance(Completer completer) async {
    CheckboxInstanceBloc instance = new CheckboxInstanceBloc(
      mold: mold,
      cast: mold.createCast(),
    );

    completer.complete(instance);
  }

  // --
  void _updateInitialValueStream() {
    _initialValueSubject.add(mold.initialValue);
  }

  void _updateTitleStream() {
    _titleSubject.add(mold.title);
  }

  void _updateSubtitleStream() {
    _subtitleSubject.add(mold.subtitle);
  }

  @override
  void dispose() {
    super.dispose();

    _initialValueSubject.close();
    _titleSubject.close();
    _subtitleSubject.close();

    _initialValueSubject.close();
    _inTitleSubject.close();
    _inSubtitleSubject.close();
    _inCreateInstanceSubject.close();
  }
}
