import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:process_way/process_way.dart';

class TemplatesPersistence {
  static const _key_templateIdsList = "templateIds";
  static const _key_templatePrefix = "template";

  Future<Null> saveTemplates(List<TemplateBloc> templates) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // save templateIds list
    await sharedPreferences.setStringList(
      _key_templateIdsList,
      templates.map((template) => template.id.toString()).toList(),
    );

    // save individual templates
    for (final template in templates) {
      Completer<Map> mapCompleter = new Completer();
      template.inToMap.add(mapCompleter);
      Map map = await mapCompleter.future;

      String json = jsonEncode(map);

      await sharedPreferences.setString(
        "$_key_templatePrefix${template.id}",
        json,
      );
    }
  }

  Future<List<TemplateBloc>> loadTemplates() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (!sharedPreferences.getKeys().contains(_key_templateIdsList)) {
      return [];
    }

    // loads list of all template ids
    List<int> ids = sharedPreferences
        .getStringList(_key_templateIdsList)
        .map(int.parse)
        .toList();

    // loads individual templates
    List<TemplateBloc> templates = [];
    for (final id in ids) {
      String jsonString =
          sharedPreferences.getString("$_key_templatePrefix$id");

      Map map = jsonDecode(jsonString);

      TemplateBloc template = TemplateBloc.fromMap(map);

      templates.add(template);
    }

    return templates;
  }
}
