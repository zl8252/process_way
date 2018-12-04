import 'package:meta/meta.dart';

@immutable
class ShowDesignerScreenInvoke {
  ShowDesignerScreenInvoke({
    @required this.templateId,
  }) : assert(templateId != null);

  final int templateId;
}
