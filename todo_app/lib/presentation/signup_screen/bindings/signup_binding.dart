

import 'package:get/get.dart';
import 'package:todo_app/presentation/login_screen/controllers/login_controller.dart';
import 'package:todo_app/presentation/signup_screen/controllers/signup_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SignUpController.new);
  }
}
