import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

import 'package:rx_widgets/rx_widgets.dart';

import 'package:process_way/process_way.dart';

class TemplateInfoHeader extends StatelessWidget {
  TemplateInfoHeader({
    @required this.template,
  }) : assert(template != null);

  final TemplateBloc template;

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.grey[200],
      elevation: 3,
      child: new Container(
        padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: new Column(
          children: <Widget>[
            new RxEditableText(
              stream: template.title,
              sink: template.inTitle,
              style: Theme.of(context).textTheme.title,
              decoration: new InputDecoration.collapsed(hintText: "Template Name"),
              maxLines: 1,
            ),
            new RxEditableText.optional(
              optionalStream: template.details,
              optionalSink: template.inDetails,
              decoration: new InputDecoration.collapsed(hintText: "Details"),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
