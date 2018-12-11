import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rx_widgets/rx_widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:process_way/process_way.dart';

class TextInstance extends StatelessWidget {
  TextInstance({
    @required this.bloc,
  }) : assert(bloc != null);

  final TextInstanceBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: new StreamBuilder<String>(
        initialData: bloc.text.value,
        stream: bloc.text,
        builder: (context, snapshot) {
          return new MarkdownBody(data: snapshot.data);
        },
      ),
    );
  }
}
