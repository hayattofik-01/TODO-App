

import 'package:get/get.dart';
import 'package:todo_app/presentation/login_screen/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LoginController.new);
  }
}
