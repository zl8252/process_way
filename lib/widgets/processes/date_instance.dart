import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rx_widgets/rx_widgets.dart';
import 'package:quiver/core.dart';

import 'package:process_way/process_way.dart';

class DateInstance extends StatelessWidget {
  DateInstance({
    @required this.bloc,
  });

  final DateInstanceBloc bloc;

  void pickDate(BuildContext context) async {
    DateTime d = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.fromMillisecondsSinceEpoch(0),
      lastDate: new DateTime(2100),
    );

    if (d == null) return;

    bloc.inDate.add(new Optional.of(d));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListTile(
        onTap: () => pickDate(context),
        title: RxText(
          bloc.title,
        ),
        trailing: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new StreamBuilder<Optional<DateTime>>(
              stream: bloc.date,
              initialData: new Optional.absent(),
              builder: (context, snapshot) {
                String s = "__.__.____";
                if (snapshot.data.isPresent) {
                  s = "${snapshot.data.value.day}.${snapshot.data.value.month}.${snapshot.data.value.year}";
                }

                return new Text(s);
              },
            ),
            new IconButton(
              icon: new Icon(Icons.clear),
              onPressed: () {
                bloc.inDate.add(new Optional.absent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
