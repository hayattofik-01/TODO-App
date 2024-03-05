import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/core/constants/routes/routes_name.dart';
import 'package:todo_app/presentation/login_screen/controllers/login_controller.dart';
import 'package:todo_app/presentation/signup_screen/controllers/signup_controller.dart';

import 'package:todo_app/presentation/signup_screen/screen_widgets/password_field.dart';
import 'package:todo_app/presentation/signup_screen/screen_widgets/text_button.dart';
import 'package:todo_app/presentation/signup_screen/screen_widgets/text_field.dart';

class LoginScreen extends GetView<LoginController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(RoutesName.intial);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login ",
                            style: kHeadline,
                          ),
                          SizedBox(height: 50),

                          Obx(() => controller.nameError.value.isNotEmpty
                              ? Text(
                                  controller.nameError.value,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox()),
                          MyTextField(
                            controller: controller.emailController,
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                            onChanged: controller.validateEmail,
                          ),
                          Obx(() => controller.emailError.value.isNotEmpty
                              ? Text(
                                  controller.emailError.value,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox()),
  Obx(() => PasswordField(
  controller: controller.passwordController,
  isPasswordVisible: controller.passwordVisibility.value,
  onTap: controller.togglePasswordVisibility,
  onChanged: controller.validatePassword,
)),

                          Obx(() => controller.passwordError.value.isNotEmpty
                              ? Text(
                                  controller.passwordError.value,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox()),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    MyTextButton(
                      buttonName: 'Login',
                      onTap: controller.signUp,
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
