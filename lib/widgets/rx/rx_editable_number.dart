import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/core.dart';

import 'package:rxdart/rxdart.dart';

class RxEditableNumber extends StatefulWidget {
  RxEditableNumber({
    @required this.stream,
    @required this.sink,
    this.style,
    this.decoration,
    this.maxLines,
  })  : assert(stream != null),
        assert(sink != null);

  final Stream<Optional<double>> stream;
  final Sink<Optional<double>> sink;

  final TextStyle style;
  final InputDecoration decoration;
  final int maxLines;

  @override
  _RxEditableNumberState createState() => _RxEditableNumberState();
}

class _RxEditableNumberState extends State<RxEditableNumber> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    String initialText = "";
    if (widget.stream is ValueObservable) {
      double value =
          (widget.stream as ValueObservable<Optional<double>>).value.orNull;
      if (value != null) initialText = "$value";
    }

    _textEditingController = new TextEditingController(text: initialText);

    _attachToStream();
  }

  @override
  void didUpdateWidget(RxEditableNumber oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.stream != widget.stream) {
      // _attachToStream();
    }
  }

  void _attachToStream() {
    widget.stream.listen(
      (Optional<double> num) {
        String str = "";
        if (!num.isPresent) {
//          str = "${num.value}";
          _textEditingController.text = str;
        }

//        if (str != _textEditingController.text) {
//          _textEditingController.text = str;
//        }
      },
    );
  }

  void _onChanged(String data) {
    double num = double.tryParse(data);

    widget.sink.add(new Optional.fromNullable(num));
  }

  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: _textEditingController,
      keyboardType: TextInputType.numberWithOptions(
        signed: true,
        decimal: true,
      ),
      style: widget.style,
      decoration: widget.decoration,
      onChanged: _onChanged,
      maxLines: widget.maxLines,
    );
  }
}
