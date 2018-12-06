import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

@immutable
class AddNewItemToGroupRequest {
  AddNewItemToGroupRequest({
    @required this.group,
  }) : assert(group != null);

  final GroupTemplateBloc group;
}
