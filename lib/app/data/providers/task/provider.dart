import 'dart:convert';

import 'package:get/get.dart';

import '../../core/keys.dart';
import '../../core/services/storage/service.dart';
import '../../models/task.dart';

class TaskProvider {
  final StorageService _storage = Get.find();

  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(tasksKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));

    return tasks;
  }

  void writeTasks(List<Task> tasks) async {
    await _storage.write(tasksKey, jsonEncode(tasks));
  }
}
