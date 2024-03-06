
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/core/constants/routes/routes_name.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (GetStorage().read('userId') != null) {
      return null; // Allow navigation to the requested route
    } else {
      return const RouteSettings(name: RoutesName.loginScreen); // Redirect to login screen
    }
  }
}