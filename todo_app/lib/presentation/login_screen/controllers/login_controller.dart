import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/provider/appwrite_provider.dart';
import 'package:todo_app/app/data/repository/auth_repository.dart';
import 'package:todo_app/app/data/response/api_response_status.dart';
import 'package:todo_app/core/constants/routes/routes_name.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = AuthRepository(AppWriteProvider());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Rx<Status> status = Status.completed.obs;
  final RxString nameError = RxString('');
  final RxString emailError = RxString('');
  final RxString passwordError = RxString('');
  final RxBool passwordVisibility = true.obs;

  bool get isSignUpEnabled =>
     
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
    
      emailError.value.isEmpty &&
      passwordError.value.isEmpty;

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  

  void validateEmail(String value) {
    // Regular expression for email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value.isEmpty) {
      emailError.value = 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(value)) {
      emailError.value = 'Enter a valid email';
    } else {
      emailError.value = '';
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = 'Password cannot be empty';
    } else if (value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
    } else {
      passwordError.value = '';
    }
  }

Future<void> signUp() async {
  try {
    if (!isSignUpEnabled) return;
    
    status(Status.loading);

    await _authRepository.login({
      
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),

    }).catchError((error){
      if (error is AppwriteException){
        Get.snackbar(
      'Error',
      error.response["message"],
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 4),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );

        
        
      }

    });

  

    // Clear the form
    
    emailController.clear();
    passwordController.clear();

    // Route to the welcome page after signing up
    Get.offNamed(RoutesName.welcome);

    status(Status.completed);
  } catch (e) {
    status(Status.error);
    rethrow;
  }
}


  @override
  void onClose() {
    
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
