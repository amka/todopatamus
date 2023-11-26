import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todopatamus/app/modules/home/widgets/task_tile.dart';

import '../../../data/models/task.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'My List',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Obx(
              () => GridView.count(
                crossAxisCount: (MediaQuery.of(context).size.width / 172)
                    .roundToDouble()
                    .toInt(),
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(12),
                children: controller.tasks
                    .map((task) => TaskTile(task: task, onLongPress: (Task task) => EasyLoading.showInfo('Task ${task.title} removed'),))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Get.defaultDialog(
            titlePadding: const EdgeInsets.symmetric(vertical: 12),
            radius: 12,
            title: 'Task Type',
            content: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextFormField(
                      controller: controller.editController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9)),
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        final task = Task(
                            title: controller.editController.text,
                            description: '',
                            icon: TablerIcons.tool.codePoint,
                            color: '');
                        Get.back();
                        controller.addTask(task)
                            ? EasyLoading.showSuccess(
                                'Created task successfully')
                            : EasyLoading.showError('Duplicated task');
                        controller.editController.clear();
                      }
                    },
                    child: const Text('Create'),
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(TablerIcons.plus),
      ),
    );
  }
}
