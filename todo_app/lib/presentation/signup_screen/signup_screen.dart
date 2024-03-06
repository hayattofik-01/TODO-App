
import 'package:todo_app/app_exports.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController _signUpController = Get.put(SignUpController());

  SignUpScreen({Key? key}) : super(key: key);

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
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Register",
                            style: kHeadline,
                          ),
                          SizedBox(height: 50.h),
                          MyTextField(
                            controller: _signUpController.nameController,
                            hintText: 'Name',
                            inputType: TextInputType.name,
                            onChanged: _signUpController.validateName,
                          ),
                          Obx(() => _signUpController.nameError.value.isNotEmpty
                              ? Text(
                                  _signUpController.nameError.value,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : const SizedBox()),
                          MyTextField(
                            controller: _signUpController.emailController,
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                            onChanged: _signUpController.validateEmail,
                          ),
                          Obx(() => _signUpController.emailError.value.isNotEmpty
                              ? Text(
                                  _signUpController.emailError.value,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : const SizedBox()),
                          Obx(() => PasswordField(
                                controller: _signUpController.passwordController,
                                isPasswordVisible: _signUpController.passwordVisibility.value,
                                onTap: _signUpController.togglePasswordVisibility,
                                onChanged: _signUpController.validatePassword,
                              )),
                          Obx(() => _signUpController.passwordError.value.isNotEmpty
                              ? Text(
                                  _signUpController.passwordError.value,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : const SizedBox()),
                          SizedBox(height: 20.h), // Added SizedBox for spacing
                          MyTextButton(
                            buttonName: 'Register',
                            onTap: _signUpController.signUp,
                            bgColor: Colors.white,
                            textColor: Colors.black87,
                          )
                        ],
                      ),
                    ),
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
