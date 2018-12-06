import 'package:process_way/process_way.dart';

class Strings {
  static String componentTypeToString(ComponentType componentType) {
    switch (componentType) {
      case ComponentType.checkboxComponent:
        return "Checkbox";
      case ComponentType.groupComponent:
        return "Group";
      case ComponentType.infoComponent:
        return "Info";
    }

    throw new Exception();
  }
}
