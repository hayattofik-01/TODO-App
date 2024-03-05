import 'package:get/get.dart';
import 'package:todo_app/core/constants/routes/routes_name.dart';
import 'package:todo_app/presentation/signup_screen/signup_screen.dart';
import 'package:todo_app/presentation/welcome_screen/welcome_screen.dart';

class AppPages {
  AppPages._();

 static final routes = [
    GetPage(
      name: RoutesName.intial,
      page: () => WelcomePage(),
      
    ),
     GetPage(
      name: RoutesName.signUpScreen,
      page: () => SignUpScreen(),
      
    ),
    
  ];
    
}