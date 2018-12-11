import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

abstract class NumberShared extends ComponentBloc {
  NumberShared({
    @required this.mold,
  }) : assert(mold != null) {
    _inLabelSubject.listen(_onInLabel);

    _updateLabelStream();
  }

  @protected
  NumberMold mold;

  @override
  ComponentType get type => ComponentType.number;

  final _labelSubject = new BehaviorSubject<String>();

  ValueObservable<String> get label => _labelSubject;

  final _inLabelSubject = new PublishSubject<String>();

  Sink<String> get inLabel => _inLabelSubject;

  Future _onInLabel(String data) async {
    mold = mold.copyWith(label: data);

    _updateLabelStream();
  }

  void _updateLabelStream() {
    _labelSubject.add(mold.label);
  }

  @override
  void dispose() {
    super.dispose();

    _labelSubject.close();
    _inLabelSubject.close();
  }
}
