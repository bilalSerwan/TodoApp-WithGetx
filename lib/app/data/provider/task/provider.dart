import 'dart:convert';

import 'package:get/get.dart';
import 'package:getx_example_app/app/core/utils/keys.dart';
import 'package:getx_example_app/app/data/models/task.dart';
import 'package:getx_example_app/app/data/services/storage/services.dart';

class TaskProvider {
  final StorageServices _storageServices = Get.find<StorageServices>();
  List<Task> readTask() {
    var tasks = <Task>[];
    jsonDecode(_storageServices.read(taskKey).toString()).forEach(
      (e) => tasks.add(
        Task.fromJson(e),
      ),
    );
    return tasks;
  }
  
  void writeTasks(List<Task> tasks){
    _storageServices.write(taskKey, jsonEncode(tasks));
  }
}
