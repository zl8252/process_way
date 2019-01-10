import 'dart:async';

import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

@immutable
class ProcessCreationBloc extends BlocBase {
  ProcessCreationBloc() {
    _inCreateComponentTemplateSubject.listen(_onInCreateComponentTemplate);
    _inCreateTemplateSubject.listen(_onInCreateTemplate);
  }

  // input
  final _inCreateComponentTemplateSubject =
      new PublishSubject<CreateComponentTemplateDelegate>();
  final _inCreateTemplateSubject = new PublishSubject<CreateTemplateDelegate>();

  Sink<CreateComponentTemplateDelegate> get inCreateComponentTemplate =>
      _inCreateComponentTemplateSubject;

  Sink<CreateTemplateDelegate> get inCreateTemplate => _inCreateTemplateSubject;

  // input handling
  Future _onInCreateComponentTemplate(
    CreateComponentTemplateDelegate delegate,
  ) async {
    switch (delegate.componentType) {
      case ComponentType.checkboxComponent:
        delegate.completer.complete(
          createCheckboxTemplate(),
        );
        break;
      case ComponentType.dateComponent:
        delegate.completer.complete(
          createDateTemplate(),
        );
        break;
      case ComponentType.groupComponent:
        delegate.completer.complete(
          createGroupTemplate(),
        );
        break;
      case ComponentType.number:
        delegate.completer.complete(
          createNumberTemplate(),
        );
        break;
      case ComponentType.text:
        delegate.completer.complete(
          createTextTemplate(),
        );
        break;
      case ComponentType.textBox:
        delegate.completer.complete(
          createTextBoxTemplate(),
        );
        break;
      case ComponentType.infoComponent:
        delegate.completer.completeError(new ArgumentError(
          "Creation of component template of desired type is not implemented",
        ));
        break;
    }
  }

  Future _onInCreateTemplate(CreateTemplateDelegate delegate) async {
    TemplateBloc template = new TemplateBloc(
      id: delegate.templateId,
      mold: new InfoMold(
        title: "Template",
        details: new Optional.absent(),
      ),
      rootGroup: new GroupTemplateBloc(
        mold: new GroupMold(title: "Root Group"),
        items: [],
      ),
    );

    delegate.completer.complete(template);
  }

  // --
  @visibleForTesting
  CheckboxTemplateBloc createCheckboxTemplate() {
    return new CheckboxTemplateBloc(
      mold: new CheckboxMold(
        initialValue: false,
        title: "Checkbox",
        subtitle: new Optional.absent(),
      ),
    );
  }

  @visibleForTesting
  DateTemplateBloc createDateTemplate() {
    return new DateTemplateBloc(
      mold: new DateMold(title: "Date"),
    );
  }

  @visibleForTesting
  GroupTemplateBloc createGroupTemplate() {
    return new GroupTemplateBloc(
      mold: new GroupMold(title: "Group"),
      items: [],
    );
  }

  @visibleForTesting
  NumberTemplateBloc createNumberTemplate() {
    return new NumberTemplateBloc(
      mold: new NumberMold(label: "Number"),
    );
  }

  @visibleForTesting
  TextTemplateBloc createTextTemplate() {
    return new TextTemplateBloc(
      mold: new TextMold(text: "Text"),
    );
  }

  @visibleForTesting
  TextBoxTemplateBloc createTextBoxTemplate() {
    return new TextBoxTemplateBloc(
      mold: new TextBoxMold(
        title: "Title",
        hint: new Optional.absent(),
      ),
    );
  }

  @override
  void dispose() {
    _inCreateComponentTemplateSubject.close();
    _inCreateTemplateSubject.close();
  }
}
