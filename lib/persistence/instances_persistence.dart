import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:process_way/process_way.dart';

class InstancesPersistence {
  static const _key_instanceIdsList = "instanceIds";
  static const _key_instancePrefix = "instance";

  Future<Null> saveInstances(List<InstanceBloc> instances) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // save instanceIds list
    await sharedPreferences.setStringList(
      _key_instanceIdsList,
      instances.map((instance) => instance.id.toString()).toList(),
    );

    // save individual instances
    for (final instance in instances) {
      Completer<Map> mapCompleter = new Completer();
      instance.inToMap.add(mapCompleter);
      Map map = await mapCompleter.future;

      String json = jsonEncode(map);

      sharedPreferences.setString(
        "$_key_instancePrefix${instance.id}",
        json,
      );
    }
  }

  Future<List<InstanceBloc>> loadInstances() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (!sharedPreferences.getKeys().contains(_key_instanceIdsList)) {
      return [];
    }

    // load list of all instance ids
    List<int> ids = sharedPreferences
        .getStringList(_key_instanceIdsList)
        .map(int.parse)
        .toList();

    // load individual instances
    List<InstanceBloc> instances = [];
    for (final id in ids) {
      String jsonString =
          sharedPreferences.getString("$_key_instancePrefix$id");

      Map map = jsonDecode(jsonString);

      InstanceBloc instance = InstanceBloc.fromMap(map);

      instances.add(instance);
    }

    return instances;
  }
}
