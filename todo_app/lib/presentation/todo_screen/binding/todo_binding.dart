

import 'package:get/get.dart';

import 'package:todo_app/presentation/todo_screen/controller/todo_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(TodoController.new);
  }
}
