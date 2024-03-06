import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  final GetStorage _getStorage = GetStorage();

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

  Future<void> login() async {
    try {
      if (!isSignUpEnabled) return;

      status(Status.loading);

      final response = await _authRepository.login({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });

      _getStorage.write('userId', response.userId);
      _getStorage.write('sessionId', response.$id);

      // Clear the form
      emailController.clear();
      passwordController.clear();

      // Route to the todo screen after logging in
      Get.offNamed(RoutesName.toDoScreen);

      status(Status.completed);
    } on AppwriteException catch (e) {
      Get.snackbar(
        'Error',
        e.response["message"] ?? 'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } on Exception catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      status(Status.completed);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
