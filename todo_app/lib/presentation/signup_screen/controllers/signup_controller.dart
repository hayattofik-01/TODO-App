import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/data/provider/appwrite_provider.dart';
import 'package:todo_app/app/data/repository/auth_repository.dart';
import 'package:todo_app/app/data/response/api_response_status.dart';
import 'package:todo_app/core/constants/routes/routes_name.dart';

class SignUpController extends GetxController {
  final AuthRepository _authRepository = AuthRepository(AppWriteProvider());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Rx<Status> status = Status.completed.obs;
  final RxString nameError = RxString('');
  final RxString emailError = RxString('');
  final RxString passwordError = RxString('');
  final RxBool passwordVisibility = true.obs;

  bool get isSignUpEnabled =>
      nameController.text.isNotEmpty &&
      emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      nameError.value.isEmpty &&
      emailError.value.isEmpty &&
      passwordError.value.isEmpty;

  void togglePasswordVisibility() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  void validateName(String value) {
    if (value.isEmpty) {
      nameError.value = 'Name cannot be empty';
    } else {
      nameError.value = '';
    }
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

    await _authRepository.signup({
      "userId": ID.unique(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "name": nameController.text.trim(),
    });

    // Show a snackbar with a success message
    Get.snackbar(
      'Success',
      'Successfully registered!',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 4),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Clear the form
    nameController.clear();
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
