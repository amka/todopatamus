import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:get/get.dart';
import 'package:todopatamus/app/modules/home/widgets/add_task_form.dart';
import 'package:todopatamus/app/modules/home/widgets/task_tile.dart';

import '../../../data/models/task.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Tasks'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                childAspectRatio: 5 / 4,
                padding: const EdgeInsets.all(12),
                children: controller.tasks
                    .map(
                      (task) => LongPressDraggable(
                        data: task,
                        onDragStarted: () => controller.setDeleting(true),
                        onDraggableCanceled: (velocity, offset) =>
                            controller.setDeleting(false),
                        onDragCompleted: () => controller.setDeleting(false),
                        feedback: Opacity(
                          opacity: 0.8,
                          child: TaskTile(task: task),
                        ),
                        child: TaskTile(task: task),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: DragTarget(
        onAccept: (Task task) {
          controller.deleteTask(task);
        },
        builder: (BuildContext context, List<Object?> candidateData,
            List<dynamic> rejectedData) {
          return Obx(
            () => FloatingActionButton(
              onPressed: () async {
                await Get.defaultDialog(
                  titlePadding: const EdgeInsets.symmetric(vertical: 12),
                  radius: 12,
                  title: 'Task Type',
                  content: AddTaskForm(controller: controller),
                );
                controller.editController.clear();
              },
              backgroundColor:
                  controller.deleting.value ? Colors.red.shade400 : null,
              foregroundColor: controller.deleting.value ? Colors.white : null,
              tooltip: controller.deleting.value ? "Delete task" : "Add task",
              child: Icon(controller.deleting.value
                  ? TablerIcons.trash_x
                  : TablerIcons.plus),
            ),
          );
        },
      ),
    );
  }
}
