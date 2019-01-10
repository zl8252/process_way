import 'dart:async';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'package:process_way/process_way.dart';

abstract class ComponentBloc extends BlocBase {
  static const _key_type = "type";
  static const _key_shape = "shape";
  static const _key_data = "data";

  static const _value_shape_template = "template";
  static const _value_shape_instance = "instance";

  ComponentBloc() {
    _onInToMapSubject.listen(_onInToMap);
  }

  static ComponentBloc fromMap(Map map) {
    String typeString = map[_key_type];
    String shape = map[_key_shape];
    Map dataMap = map[_key_data];

    ComponentType type = componentTypeFromString(typeString);
    switch (type) {
      case ComponentType.checkboxComponent:
        {
          if (shape == _value_shape_template) {
            return CheckboxTemplateBloc.fromMap(dataMap);
          } else if (shape == _value_shape_instance) {
            return CheckboxInstanceBloc.fromMap(dataMap);
          }
          break;
        }
      case ComponentType.dateComponent:
        {
          if (shape == _value_shape_template) {
            return DateTemplateBloc.fromMap(dataMap);
          } else if (shape == _value_shape_instance) {
            return DateInstanceBloc.fromMap(dataMap);
          }
          break;
        }
      case ComponentType.groupComponent:
        {
          if (shape == _value_shape_template) {
            return GroupTemplateBloc.fromMap(dataMap);
          } else if (shape == _value_shape_instance) {
            return GroupInstanceBloc.fromMap(dataMap);
          }
          break;
        }
      case ComponentType.number:
        {
          if (shape == _value_shape_template)
            return NumberTemplateBloc.fromMap(dataMap);
          else if (shape == _value_shape_instance)
            return NumberInstanceBloc.fromMap(dataMap);
          break;
        }
      case ComponentType.text:
        {
          if (shape == _value_shape_template)
            return TextTemplateBloc.fromMap(dataMap);
          else if (shape == _value_shape_instance)
            return TextInstanceBloc.fromMap(dataMap);
          break;
        }
      case ComponentType.textBox:
        {
          if (shape == _value_shape_template)
            return TextBoxTemplateBloc.fromMap(dataMap);
          else if (shape == _value_shape_instance)
            return TextBoxInstanceBloc.fromMap(dataMap);
          break;
        }
      case ComponentType.infoComponent:
        break;
    }

    throw new Exception();
  }

  ComponentType get type;

  final _onInToMapSubject = new PublishSubject<Completer<Map>>();

  Sink<Completer<Map>> get inToMap => _onInToMapSubject;

  Future _onInToMap(Completer<Map> completer) async {
    Map map = <String, dynamic>{
      _key_type: componentTypeToString(type),
      _key_shape: _toShapeString(),
      _key_data: await toMap(),
    };

    completer.complete(map);
  }

  Future<Map> toMap();

  String _toShapeString() {
    if (this is IComponentTemplateBloc) {
      return _value_shape_template;
    }
    if (this is IComponentInstanceBloc) {
      return _value_shape_instance;
    }

    throw new Exception();
  }

  @override
  @mustCallSuper
  void dispose() {
    _onInToMapSubject.close();
  }
}
