import 'dart:async';

import 'package:process_way/process_way.dart';

class InstancesRepository {
  Map<int, InstanceBloc> _instances = new Map();

  Future<List<InstanceBloc>> loadAllInstances() async {
    return _instances.values.toList();
  }

  Future<Null> replaceWithNewInstances(List<InstanceBloc> instances) async {
    _instances.clear();
    for (final instance in instances){
      await saveInstance(instance);
    }
  }

  Future<InstanceBloc> loadInstanceById(int instanceId) async {
    if (!_instances.containsKey(instanceId)) {
      throw new Exception(
        "Instance with the given id:$instanceId does not exist",
      );
    }

    return _instances[instanceId];
  }

  Future<Null> saveInstance(InstanceBloc instance) async {
    _instances[instance.id] = instance;
  }

  Future<Null> deleteInstanceWithId(int instanceId) async {
    _instances.remove(instanceId);
  }

  Future<int> generateUniqueInstanceId() async {
    int idCandidate = new DateTime.now().millisecondsSinceEpoch;
    while (_instances.containsKey(idCandidate)) {
      idCandidate++;
    }

    return idCandidate;
  }
}
