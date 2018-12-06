import 'dart:async';

import 'package:flutter/material.dart';

class RxCheckbox extends StatelessWidget {
  RxCheckbox({
    @required this.stream,
    this.sink,
  })  : assert(stream != null);

  final Stream<bool> stream;
  final Sink<bool> sink;

  void _onChange(bool value) {
    sink.add(value);
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<bool>(
      initialData: false,
      stream: stream,
      builder: (context, snapshot) {
        return new Checkbox(
          value: snapshot.data,
          onChanged: sink != null ? _onChange : null,
        );
      },
    );
  }
}
