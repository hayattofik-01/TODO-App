import 'package:get/get.dart';
import 'package:todo_app/core/constants/routes/middleware/auth_middleware.dart';
import 'package:todo_app/core/constants/routes/routes_name.dart';
import 'package:todo_app/presentation/login_screen/bindings/login_binding.dart';
import 'package:todo_app/presentation/login_screen/login_screen.dart';
import 'package:todo_app/presentation/signup_screen/bindings/signup_binding.dart';
import 'package:todo_app/presentation/signup_screen/signup_screen.dart';
import 'package:todo_app/presentation/todo_screen/binding/todo_binding.dart';
import 'package:todo_app/presentation/todo_screen/todo_screen.dart';
import 'package:todo_app/presentation/welcome_screen/welcome_screen.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: RoutesName.intial,
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: RoutesName.signUpScreen,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: RoutesName.loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RoutesName.toDoScreen,
      page: () => TodoScreen(),
      binding: TodoBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}