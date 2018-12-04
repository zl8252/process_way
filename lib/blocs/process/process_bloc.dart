import 'dart:async';

import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

abstract class ProcessBloc extends BlocBase {
  ProcessBloc({
    @required this.mold,
  }) : assert(mold != null) {
    _inTitleSubject.listen(_onInTitle);
    _inDetailsSubject.listen(_onInDetails);

    _updateTitleStream();
    _updateDetailsStream();
  }

  @protected
  InfoMold mold;

  // output
  final _titleSubject = new BehaviorSubject<String>();
  final _detailsSubject = new BehaviorSubject<Optional<String>>();

  ValueObservable<String> get title => _titleSubject;

  ValueObservable<Optional<String>> get details => _detailsSubject;

  // input
  final _inTitleSubject = new PublishSubject<String>();
  final _inDetailsSubject = new PublishSubject<Optional<String>>();

  Sink<String> get inTitle => _inTitleSubject;

  Sink<Optional<String>> get inDetails => _inDetailsSubject;

  // input handling
  Future _onInTitle(String data) async {
    mold = mold.copyWith(title: data);

    _updateTitleStream();
  }

  Future _onInDetails(Optional<String> data) async {
    mold = mold.copyWith(details: data);

    _updateDetailsStream();
  }

  // --
  void _updateTitleStream() {
    _titleSubject.add(mold.title);
  }

  void _updateDetailsStream() {
    _detailsSubject.add(mold.details);
  }

  @override
  @mustCallSuper
  void dispose() {
    _titleSubject.close();
    _detailsSubject.close();

    _inTitleSubject.close();
    _inDetailsSubject.close();
  }
}
