import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import screen_utils package
import 'package:get/get.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/constants/routes/routes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/core/constants/routes/routes_name.dart';


void main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  static final userId = GetStorage().read("userId");

  static final initial = userId != null ? RoutesName.toDoScreen : RoutesName.intial;

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Design size of the device
      builder: (context, _) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Sign In Sign Up Ui',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          
        ),
         initialRoute: initial, // Set initial route
          getPages: AppPages.routes, // Use the routes defined in AppPages
        
      ),
    );
  }
}
