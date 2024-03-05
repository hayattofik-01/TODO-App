import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/constants/constants.dart';
import 'package:todo_app/presentation/signup_screen/controllers/signup_controller.dart';

import 'package:todo_app/presentation/signup_screen/screen_widgets/password_field.dart';
import 'package:todo_app/presentation/signup_screen/screen_widgets/text_button.dart';
import 'package:todo_app/presentation/signup_screen/screen_widgets/text_field.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController _signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
                            "Register",
                            style: kHeadline,
                          ),
                          SizedBox(height: 50),
                          MyTextField(
                            controller: _signUpController.nameController,
                            hintText: 'Name',
                            inputType: TextInputType.name,
                            onChanged: _signUpController.validateName,
                          ),
                          Obx(() => _signUpController.nameError.value.isNotEmpty
                              ? Text(
                                  _signUpController.nameError.value,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox()),
                          MyTextField(
                            controller: _signUpController.emailController,
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                            onChanged: _signUpController.validateEmail,
                          ),
                          Obx(() => _signUpController.emailError.value.isNotEmpty
                              ? Text(
                                  _signUpController.emailError.value,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox()),
                          PasswordField(
                            controller: _signUpController.passwordController,
                            isPasswordVisible:
                                _signUpController.passwordVisibility.value,
                            onTap: _signUpController.togglePasswordVisibility,
                            onChanged: _signUpController.validatePassword,
                          ),
                          Obx(() => _signUpController.passwordError.value.isNotEmpty
                              ? Text(
                                  _signUpController.passwordError.value,
                                  style: TextStyle(color: Colors.red),
                                )
                              : SizedBox()),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    MyTextButton(
                      buttonName: 'Register',
                      onTap: _signUpController.signUp,
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
