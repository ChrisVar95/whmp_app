import 'dart:convert';
import 'package:get/get.dart';

import '../../../core/utils/keys.dart';
import '../../model/task.dart';
import '../../services/storage/services.dart';

class TaskProvider {
  final StorageService _storage = Get.find<StorageService>();

  List<Task> readTasks() {
    var tasks = <Task>[];
    // Use _storage to read the local storage data
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    // Map individual into Task object and add to list
    return tasks;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
