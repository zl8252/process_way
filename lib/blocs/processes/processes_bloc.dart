import 'dart:async';
import 'dart:collection';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

class ProcessesBloc extends BlocBase {
  ProcessesBloc({
    @required InstancesRepository instancesRepository,
    @required TemplatesRepository templatesRepository,
    @required ProcessCreationBloc processCreationBloc,
  })  : assert(instancesRepository != null),
        assert(templatesRepository != null),
        assert(processCreationBloc != null),
        _instancesRepository = instancesRepository,
        _templatesRepository = templatesRepository,
        _processCreationBloc = processCreationBloc {
    _inCreateNewTemplateSubject.listen(_onInCreateNewTemplate);
    _inCreateInstanceFromTemplateSubject
        .listen(_onInCreateInstanceFromTemplate);
    _inMoveInstanceSubject.listen(_onInMoveInstance);
    _inLoadInstanceSubject.listen(_onInLoadInstance);
    _inLoadTemplateSubject.listen(_onInLoadTemplate);
    _inSaveInstanceSubject.listen(_onInSaveInstance);
    _inSaveTemplateSubject.listen(_onInSaveTemplate);
    _inDeleteInstanceSubject.listen(_onInDeleteInstance);
    _inDeleteTemplateSubject.listen(_onInDeleteTemplate);

    _updateInstancesStream();
    _updateTemplatesStream();
  }

  final InstancesRepository _instancesRepository;
  final TemplatesRepository _templatesRepository;

  final ProcessCreationBloc _processCreationBloc;

  // output
  final _instancesSubject =
      new BehaviorSubject<UnmodifiableListView<InstanceBloc>>();
  final _templatesSubject =
      new BehaviorSubject<UnmodifiableListView<TemplateBloc>>();
  final _outInstanceCreatedNotificationSubject = new BehaviorSubject<Null>();

  Observable<UnmodifiableListView<InstanceBloc>> get instances =>
      _instancesSubject;

  Observable<UnmodifiableListView<TemplateBloc>> get templates =>
      _templatesSubject;

  Observable<Null> get outInstanceCreatedNotification =>
      _outInstanceCreatedNotificationSubject;

  // input
  final _inCreateNewTemplateSubject = new PublishSubject<Null>();
  final _inCreateInstanceFromTemplateSubject = new PublishSubject<int>();
  final _inMoveInstanceSubject = new PublishSubject<MoveInstanceRequest>();
  final _inLoadInstanceSubject = new PublishSubject<LoadInstanceDelegate>();
  final _inLoadTemplateSubject = new PublishSubject<LoadTemplateDelegate>();
  final _inSaveInstanceSubject = new PublishSubject<InstanceBloc>();
  final _inSaveTemplateSubject = new PublishSubject<TemplateBloc>();
  final _inDeleteInstanceSubject = new PublishSubject<int>();
  final _inDeleteTemplateSubject = new PublishSubject<int>();

  Sink<Null> get inCreateNewTemplate => _inCreateNewTemplateSubject;

  Sink<int> get inCreateInstanceFromTemplate =>
      _inCreateInstanceFromTemplateSubject;

  Sink<MoveInstanceRequest> get inMoveInstance => _inMoveInstanceSubject;

  Sink<LoadInstanceDelegate> get inLoadInstance => _inLoadInstanceSubject;

  Sink<LoadTemplateDelegate> get inLoadTemplate => _inLoadTemplateSubject;

  Sink<InstanceBloc> get inSaveInstance => _inSaveInstanceSubject;

  Sink<TemplateBloc> get inSaveTemplate => _inSaveTemplateSubject;

  Sink<int> get inDeleteInstance => _inDeleteInstanceSubject;

  Sink<int> get inDeleteTemplate => _inDeleteTemplateSubject;

  // input handling
  Future _onInCreateNewTemplate(_) async {
    int templateId = await _templatesRepository.generateUniqueTemplateId();

    Completer<TemplateBloc> templateCompleter = new Completer();
    _processCreationBloc.inCreateTemplate.add(
      new CreateTemplateDelegate(
        templateId: templateId,
        completer: templateCompleter,
      ),
    );
    TemplateBloc template = await templateCompleter.future;

    await _templatesRepository.saveTemplate(template);

    _updateTemplatesStream();
  }

  Future _onInCreateInstanceFromTemplate(int templateId) async {
    TemplateBloc template =
        await _templatesRepository.loadTemplateById(templateId);

    int instanceId = await _instancesRepository.generateUniqueInstanceId();
    Completer<InstanceBloc> instanceCompleter = new Completer();

    template.inCreateInstance.add(
      new CreateInstanceDelegate(
        instanceId: instanceId,
        completer: instanceCompleter,
      ),
    );

    InstanceBloc instance = await instanceCompleter.future;

    await _instancesRepository.saveInstance(instance);

    _updateInstancesStream();
    _outInstanceCreatedNotificationSubject.add(null);
  }

  Future _onInMoveInstance(MoveInstanceRequest request) async {
    List<InstanceBloc> instances =
        await _instancesRepository.loadAllInstances();

    if (!instances.contains(request.instance)) return;

    int initialIndex = instances.indexOf(request.instance);
    int newIndex;
    switch (request.direction) {
      case MoveItemDirection.up:
        newIndex = initialIndex - 1;
        break;
      case MoveItemDirection.down:
        newIndex = initialIndex + 1;
        break;
    }
    instances.remove(request.instance);
    newIndex = newIndex.clamp(0, instances.length);
    instances.insert(newIndex, request.instance);
    await _instancesRepository.replaceWithNewInstances(instances);

    _updateInstancesStream();
  }

  Future _onInLoadInstance(LoadInstanceDelegate delegate) async {
    try {
      InstanceBloc instance =
          await _instancesRepository.loadInstanceById(delegate.instanceId);

      delegate.completer.complete(instance);
    } catch (e) {
      delegate.completer.completeError(e);
    }
  }

  Future _onInLoadTemplate(LoadTemplateDelegate delegate) async {
    try {
      TemplateBloc template =
          await _templatesRepository.loadTemplateById(delegate.templateId);

      delegate.completer.complete(template);
    } catch (e) {
      delegate.completer.completeError(e);
    }
  }

  Future _onInSaveInstance(InstanceBloc instance) async {
    await _instancesRepository.saveInstance(instance);

    _updateInstancesStream();
  }

  Future _onInSaveTemplate(TemplateBloc template) async {
    await _templatesRepository.saveTemplate(template);

    _updateTemplatesStream();
  }

  Future _onInDeleteInstance(int instanceId) async {
    _instancesRepository.deleteInstanceWithId(instanceId);

    _updateInstancesStream();
  }

  Future _onInDeleteTemplate(int templateId) async {
    await _templatesRepository.deleteTemplateWithId(templateId);

    _updateTemplatesStream();
  }

  // --
  Future _updateInstancesStream() async {
    List<InstanceBloc> instances =
        await _instancesRepository.loadAllInstances();

    _instancesSubject.add(new UnmodifiableListView(instances));
  }

  Future _updateTemplatesStream() async {
    List<TemplateBloc> templates =
        await _templatesRepository.loadAllTemplates();

    _templatesSubject.add(new UnmodifiableListView(templates));
  }

  @override
  void dispose() {
    _instancesSubject.close();
    _templatesSubject.close();
    _outInstanceCreatedNotificationSubject.close();

    _inCreateNewTemplateSubject.close();
    _inCreateInstanceFromTemplateSubject.close();
    _inMoveInstanceSubject.close();
    _inLoadInstanceSubject.close();
    _inLoadTemplateSubject.close();
    _inSaveInstanceSubject.close();
    _inSaveTemplateSubject.close();
    _inDeleteInstanceSubject.close();
    _inDeleteTemplateSubject.close();
  }
}
