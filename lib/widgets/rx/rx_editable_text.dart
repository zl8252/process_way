import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:quiver/core.dart';

class RxEditableText extends StatefulWidget {
  RxEditableText({
    @required this.stream,
    @required this.sink,
    this.style,
    this.decoration,
    this.maxLines,
    this.textAlign = TextAlign.start,
  })  : optionalStream = null,
        optionalSink = null,
        assert(stream != null),
        assert(sink != null);

  RxEditableText.optional({
    @required this.optionalStream,
    @required this.optionalSink,
    this.style,
    this.decoration,
    this.maxLines,
    this.textAlign = TextAlign.start,
  })  : stream = null,
        sink = null,
        assert(optionalStream != null),
        assert(optionalSink != null);

  final Stream<String> stream;
  final Sink<String> sink;

  final Stream<Optional<String>> optionalStream;
  final Sink<Optional<String>> optionalSink;

  final TextStyle style;
  final InputDecoration decoration;
  final int maxLines;
  final TextAlign textAlign;

  @override
  _RxEditableTextState createState() => _RxEditableTextState();
}

class _RxEditableTextState extends State<RxEditableText> {
  bool get _isOptional => widget.optionalSink != null;

  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();

    _textEditingController =
        new TextEditingController(text: _determineInitialText());
    _attachToStream();
  }

  String _determineInitialText() {
    if (_isOptional) {
      if (widget.optionalStream is ValueObservable) {
        return (widget.optionalStream as ValueObservable<Optional<String>>)
            .value
            .or("");
      }
    } else {
      if (widget.stream is ValueObservable) {
        return (widget.stream as ValueObservable).value;
      }
    }

    return "";
  }

  @override
  void didUpdateWidget(RxEditableText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.stream != oldWidget.stream) {
      _attachToStream();
    }
  }

  void _attachToStream() {
    void listen(String text) {
      if (text != _textEditingController.text) {
        _textEditingController.text = text;
      }
    }

    if (_isOptional) {
      widget.optionalStream.map((optional) => optional.or("")).listen(listen);
    } else {
      widget.stream.listen(listen);
    }
  }

  void _onTextChanged(String text) {
    if (_isOptional) {
      Optional<String> optionalText =
          text == "" ? new Optional.absent() : new Optional.of(text);

      widget.optionalSink.add(optionalText);
    } else {
      widget.sink.add(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: _textEditingController,
      style: widget.style,
      decoration: widget.decoration,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      onChanged: _onTextChanged,
    );
  }
}
