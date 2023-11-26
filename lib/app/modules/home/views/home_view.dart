import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:get/get.dart';
import 'package:todopatamus/app/modules/home/widgets/task_tile.dart';

import '../../../data/models/task.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
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
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 5/4,
                padding: const EdgeInsets.all(12),
                children: controller.tasks
                    .map(
                      (task) => TaskTile(
                        task: task,
                        onLongPress: (Task task) => EasyLoading.showInfo(
                          'Task ${task.title} removed',
                        ),
                      ),
                    )
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
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Enter task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              final task = Task(
                                  title: controller.editController.text,
                                  description: '',
                                  icon: TablerIcons.tool.codePoint,
                                  color: '');
                              if (controller.addTask(task)) {
                                EasyLoading.showSuccess(
                                    'Created task successfully');
                                Get.back();
                              } else {
                                EasyLoading.showError('Duplicated task',
                                    duration: Duration(milliseconds: 150));
                              }
                            }
                          },
                          child: const Text('Create'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          controller.editController.clear();
        },
        child: const Icon(TablerIcons.plus),
      ),
    );
  }
}
