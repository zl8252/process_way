import 'package:meta/meta.dart';

@immutable
class StartDesigningRequest {
  StartDesigningRequest({
    @required this.templateId,
  }) : assert(templateId != null);

  final int templateId;
}
