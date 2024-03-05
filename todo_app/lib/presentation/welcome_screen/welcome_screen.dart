import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/constants/routes/routes_name.dart';
import 'package:todo_app/presentation/signup_screen/signup_screen.dart';
import 'package:todo_app/presentation/welcome_screen/screen_widgets/my_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40.h,
            vertical: 40.h,
          ),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Center(
                        child: Container(
                          width: 300.w,
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: SvgPicture.asset(
                              'assets/images/todo.svg',
                              width: 300.w,
                              height: 300.h,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    Text(
                      "Manage your tasks with ease",
                      style: kHeadline,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      width: 300.w,
                      child: Text(
                        "create list of todos, mark them completed when finished , and also track what is done or need to be done",
                        style: kBodyText,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(18.h),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: MyTextButton(
                        bgColor: Colors.white,
                        buttonName: 'Register',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        textColor: Colors.black87,
                      ),
                    ),
                    Expanded(
                      child: MyTextButton(
                        bgColor: Colors.transparent,
                        buttonName: 'Login',
                        onTap: () {
Get.offNamed(RoutesName.loginScreen);
                        },
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
