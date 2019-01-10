import 'package:process_way/process_way.dart';

enum ComponentType {
  infoComponent,
  checkboxComponent,
  dateComponent,
  groupComponent,
  number,
  text,
  textBox,
}

String componentTypeToString(ComponentType componentType) {
  switch (componentType) {
    case ComponentType.infoComponent:
      return "infoComponent";
    case ComponentType.checkboxComponent:
      return "checkboxComponent";
    case ComponentType.dateComponent:
      return "dateComponent";
    case ComponentType.groupComponent:
      return "groupComponent";
    case ComponentType.number:
      return "numberComponent";
    case ComponentType.text:
      return "textComponent";
    case ComponentType.textBox:
      return "textBoxComponent";
  }

  throw new Exception();
}

ComponentType componentTypeFromString(String s) {
  if (s == "infoComponent") return ComponentType.infoComponent;
  if (s == "checkboxComponent") return ComponentType.checkboxComponent;
  if (s == "dateComponent") return ComponentType.dateComponent;
  if (s == "groupComponent") return ComponentType.groupComponent;
  if (s == "numberComponent") return ComponentType.number;
  if (s == "textComponent") return ComponentType.text;
  if (s == "textBoxComponent") return ComponentType.textBox;

  throw new Exception();
}
