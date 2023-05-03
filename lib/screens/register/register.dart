import 'package:api/utils/app_urls.dart';
import 'package:api/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../widgets/text_input.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              children: [
                Text(
                  'Create an account',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: 'Kufam',
                    color: Colors.pinkAccent,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextInput(
                  controller: controller.usernameController,
                  hintText: 'Username',
                  keyboardType: TextInputType.text,
                  onSaved: (value) => controller.username = value!,
                  validator: (value) => controller.validateUserName(value!),
                  prefixIcon: true,
                  icon: Icons.person_4,
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextInput(
                  controller: controller.emailController,
                  hintText: 'Email address',
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => controller.email = value!,
                  validator: (value) => controller.validateEmail(value!),
                  prefixIcon: true,
                  icon: Icons.email,
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextInput(
                  controller: controller.passwordController,
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (value) => controller.password = value!,
                  validator: (value) => controller.validatePassword(value!),
                  prefixIcon: true,
                  icon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(
                  height: 15.h,
                ),
                CustomTextInput(
                  controller: controller.confirmPasswordController,
                  hintText: 'Confirm password',
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (value) => controller.confirmPassword = value!,
                  validator: (value) =>
                      controller.validateConfirmPassword(value!),
                  prefixIcon: true,
                  icon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  width: double.maxFinite,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () => controller.submitForm(),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'By registering, you confirm that you accept our Terms of Service and Privacy policy',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.facebook,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 10.h,
                ),
                SocialLoginButton(
                  buttonType: SocialLoginButtonType.google,
                  onPressed: () {},
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                    onTap: () => Get.offNamed(AppUrls.loginRoute),
                    child: Text(
                      'Have an account ? Sign in.',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 23, 105, 172),
                        fontSize: 14.sp,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
