import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rx_widgets/rx_widgets.dart';

import 'package:process_way/process_way.dart';

class CheckboxInstance extends StatelessWidget {
  CheckboxInstance({
    @required this.bloc,
  }) : assert(bloc != null);

  final CheckboxInstanceBloc bloc;

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<bool>(
      initialData: bloc.isChecked.value,
      stream: bloc.isChecked,
      builder: (context, snapshot) {
        return new CheckboxListTile(
          value: snapshot.data,
          onChanged: (v) => bloc.inIsChecked.add(v),
          title: new RxText(bloc.title),
          subtitle: bloc.subtitle.value.isPresent
              ? new RxOptionalText(bloc.subtitle)
              : null,
        );
      },
    );
  }
}
