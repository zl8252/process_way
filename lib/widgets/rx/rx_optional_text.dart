import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

class RxOptionalText extends StatelessWidget {
  RxOptionalText(
    this.optionalText, {
    this.style,
  }) : assert(optionalText != null);

  final Stream<Optional<String>> optionalText;

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<Optional<String>>(
      initialData: new Optional.absent(),
      stream: optionalText,
      builder: (context, snapshot) {
        Optional<String> data = snapshot.data;

        if (data.isPresent) {
          return new Text(
            data.value,
            style: style,
          );
        } else {
          return new Container();
        }
      },
    );
  }
}
