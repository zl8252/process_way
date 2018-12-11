import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

abstract class TextShared extends ComponentBloc {
  TextShared({
    @required this.mold,
  }) : assert(mold != null) {
    _inTextSubject.listen(_onInText);

    _updateTextStream();
  }

  @protected
  TextMold mold;

  @override
  ComponentType get type => ComponentType.text;

  final _textSubject = new BehaviorSubject<String>();

  ValueObservable<String> get text => _textSubject;

  final _inTextSubject = new PublishSubject<String>();

  Sink<String> get inText => _inTextSubject;

  Future _onInText(String data) async {
    mold = mold.copyWith(text: data);

    _updateTextStream();
  }

  void _updateTextStream() {
    _textSubject.add(mold.text);
  }

  @override
  void dispose() {
    super.dispose();

    _textSubject.close();
    _inTextSubject.close();
  }
}
