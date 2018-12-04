import 'package:process_way/process_way.dart';

enum ComponentType {
  infoComponent,
  checkboxComponent,
  groupComponent,
}

String componentTypeToString(ComponentType componentType) {
  switch (componentType) {
    case ComponentType.infoComponent:
      return "infoComponent";
    case ComponentType.checkboxComponent:
      return "checkboxComponent";
    case ComponentType.groupComponent:
      return "groupComponent";
  }

  throw new Exception();
}

ComponentType componentTypeFromString(String s) {
  if (s == "infoComponent") return ComponentType.infoComponent;
  if (s == "checkboxComponent") return ComponentType.checkboxComponent;
  if (s == "groupComponent") return ComponentType.groupComponent;

  throw new Exception();
}
