import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

class DesigningScreenBloc extends BlocBase {
  DesigningScreenBloc({
    @required int templateId,
    @required ProcessesBloc processesBloc,
    @required ProcessCreationBloc processCreationBloc,
  })  : assert(templateId != null),
        assert(processesBloc != null),
        assert(processCreationBloc != null),
        _templateId = templateId,
        _processesBloc = processesBloc,
        _processCreationBloc = processCreationBloc {
    _inAddNewComponentToGroupSubject.listen(_onInAddNewComponentToGroup);
    _inSaveAndDismissScreenSubject.listen(_onInSaveAndDismissScreen);

    _loadTemplate();
  }

  final int _templateId;
  TemplateBloc _template;

  final ProcessesBloc _processesBloc;
  final ProcessCreationBloc _processCreationBloc;

  // output
  final _templateSubject = new BehaviorSubject<TemplateBloc>();
  final _outPickComponentTypeSubject =
      new BehaviorSubject<PickComponentTypeInvoke>();
  final _outDismissScreenSubject = new BehaviorSubject<Null>();

  Observable<TemplateBloc> get template => _templateSubject;

  Observable<PickComponentTypeInvoke> get outPickComponentType =>
      _outPickComponentTypeSubject;

  Observable<Null> get outDismissScreen => _outDismissScreenSubject;

  // input
  final _inAddNewComponentToGroupSubject =
      new BehaviorSubject<AddNewComponentToGroupRequest>();
  final _inSaveAndDismissScreenSubject = new BehaviorSubject<Null>();

  Sink<AddNewComponentToGroupRequest> get inAddNewComponentToGroup =>
      _inAddNewComponentToGroupSubject;

  Sink<Null> get inSaveAndDismissScreen => _inSaveAndDismissScreenSubject;

  // input handling
  Future _onInAddNewComponentToGroup(
    AddNewComponentToGroupRequest request,
  ) async {
    // pick component type
    Completer<ComponentType> componentTypeCompleter = new Completer();
    _outPickComponentTypeSubject.add(
      new PickComponentTypeInvoke(completer: componentTypeCompleter),
    );
    ComponentType componentType = await componentTypeCompleter.future;

    // create the component
    Completer<IComponentTemplate> componentCompleter = new Completer();
    _processCreationBloc.inCreateComponentTemplate.add(
      new CreateComponentTemplateDelegate(
        componentType: componentType,
        completer: componentCompleter,
      ),
    );
    IComponentTemplate component = await componentCompleter.future;

    // add component to group
    request.group.inAddComponentAtBack.add(component);
  }

  Future _onInSaveAndDismissScreen(_) async {
    if (_template != null) {
      _processesBloc.inSaveTemplate.add(_template);
    }
    _dismissScreen();
  }

  // --
  void _updateTemplateStream() {
    _templateSubject.add(_template);
  }

  void _dismissScreen() {
    _outDismissScreenSubject.add(null);
  }

  Future _loadTemplate() async {
    Completer<TemplateBloc> templateCompleter = new Completer();

    _processesBloc.inLoadTemplate.add(
      new LoadTemplateDelegate(
        templateId: _templateId,
        completer: templateCompleter,
      ),
    );

    _template = await templateCompleter.future;

    _updateTemplateStream();
  }

  @override
  void dispose() {
    _templateSubject.close();
    _outPickComponentTypeSubject.close();
    _outDismissScreenSubject.close();

    _inAddNewComponentToGroupSubject.close();
    _inSaveAndDismissScreenSubject.close();
  }
}
