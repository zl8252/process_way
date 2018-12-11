import 'package:process_way/process_way.dart';

class Strings {
  static String componentTypeToString(ComponentType componentType) {
    switch (componentType) {
      case ComponentType.checkboxComponent:
        return "CheckBox";
      case ComponentType.groupComponent:
        return "Group";
      case ComponentType.infoComponent:
        return "Info";
      case ComponentType.number:
        return "Number";
      case ComponentType.text:
        return "Text";
      case ComponentType.textBox:
        return "TextBox";
    }

    throw new Exception();
  }
}
