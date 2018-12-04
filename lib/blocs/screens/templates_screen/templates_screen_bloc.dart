import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

class TemplatesScreenBloc extends BlocBase {
  TemplatesScreenBloc() {
    _inStartDesigningSubject.listen(_onInStartDesigning);
  }

  // output
  final _outShowDesignerScreen =
      new BehaviorSubject<ShowDesignerScreenInvoke>();

  Observable<ShowDesignerScreenInvoke> get outShowDesignerScreen =>
      _outShowDesignerScreen;

  // input
  final _inStartDesigningSubject = new PublishSubject<StartDesigningRequest>();

  Sink<StartDesigningRequest> get inStartDesigning => _inStartDesigningSubject;

  // input handling
  Future _onInStartDesigning(StartDesigningRequest request) async {
    int templateId = request.templateId;

    _outShowDesignerScreen.add(
      new ShowDesignerScreenInvoke(
        templateId: templateId,
      ),
    );
  }

  // --

  @override
  void dispose() {
    _outShowDesignerScreen.close();

    _inStartDesigningSubject.close();
  }
}
