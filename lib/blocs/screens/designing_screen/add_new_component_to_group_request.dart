import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

@immutable
class AddNewComponentToGroupRequest {
  AddNewComponentToGroupRequest({
    @required this.group,
  }) : assert(group != null);

  final GroupTemplate group;
}
