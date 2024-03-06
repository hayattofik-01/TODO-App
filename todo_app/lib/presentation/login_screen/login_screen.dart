

import 'package:todo_app/app_exports.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

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
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Login ",
                            style: kHeadline,
                          ),
                          SizedBox(height: 50.h),
                          Obx(() => controller.nameError.value.isNotEmpty
                              ? Text(
                                  controller.nameError.value,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : const SizedBox()),
                          MyTextField(
                            controller: controller.emailController,
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                            onChanged: controller.validateEmail,
                          ),
                          Obx(() => controller.emailError.value.isNotEmpty
                              ? Text(
                                  controller.emailError.value,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : const SizedBox()),
                          Obx(() => PasswordField(
                                controller: controller.passwordController,
                                isPasswordVisible:
                                    controller.passwordVisibility.value,
                                onTap: controller.togglePasswordVisibility,
                                onChanged: controller.validatePassword,
                              )),
                          Obx(() => controller.passwordError.value.isNotEmpty
                              ? Text(
                                  controller.passwordError.value,
                                  style: const TextStyle(color: Colors.red),
                                )
                              : const SizedBox()),
                          // Add a Spacer or Expanded widget
                          SizedBox(height: 10.h,),
                          MyTextButton(
                            buttonName: 'Login',
                            onTap: controller.login,
                            bgColor: Colors.white,
                            textColor: Colors.black87,
                          ),
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
