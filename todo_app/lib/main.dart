import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import screen_utils package
import 'package:get/get.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/constants/routes/routes.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
         initialRoute: '/', // Set initial route
          getPages: AppPages.routes, // Use the routes defined in AppPages
        
      ),
    );
  }
}
