import 'package:get/get.dart';
import 'package:todopatamus/app/data/models/task.dart';

class TaskDetailsController extends GetxController {
  final count = 0.obs;
  
  final task = Rx<Task?>(null);

  @override
  void onInit() {
    super.onInit();

    task.value = Get.arguments['task'];
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
