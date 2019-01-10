import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:process_way/process_way.dart';

class DateTemplate extends StatelessWidget {
  DateTemplate({
    @required this.bloc,
  });

  final DateTemplateBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: new EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: new RxEditableText(
        stream: bloc.title,
        sink: bloc.inTitle,
        decoration: new InputDecoration.collapsed(hintText: "Title"),
        style: Theme.of(context).textTheme.title,
      ),
    );
  }
}
