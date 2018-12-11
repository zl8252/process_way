import 'dart:async';

import 'package:process_way/process_way.dart';

class TemplatesRepository {
  Map<int, TemplateBloc> _templates = new Map();

  Future<List<TemplateBloc>> loadAllTemplates() async {
    return _templates.values.toList();
  }

  Future<Null> replaceWithNewTemplates(List<TemplateBloc> templates) async {
    _templates.clear();
    for (final template in templates) {
      await saveTemplate(template);
    }
  }

  Future<TemplateBloc> loadTemplateById(int templateId) async {
    if (!_templates.containsKey(templateId)) {
      throw new Exception(
        "Template with the given id:$templateId does not exist",
      );
    }

    return _templates[templateId];
  }

  Future<Null> saveTemplate(TemplateBloc template) async {
    int templateId = template.id;

    _templates[templateId] = template;
  }

  Future<Null> deleteTemplateWithId(int templateId) async {
    _templates.remove(templateId);
  }

  Future<int> generateUniqueTemplateId() async {
    int idCandidate = new DateTime.now().millisecondsSinceEpoch;
    while (_templates.containsKey(idCandidate)) {
      idCandidate++;
    }
    return idCandidate;
  }
}
