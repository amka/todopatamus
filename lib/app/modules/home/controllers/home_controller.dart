import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/core/services/storage/repository.dart';
import '../../../data/models/task.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final tasks = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();

    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }

    tasks.add(task);
    return true;
  }
}
