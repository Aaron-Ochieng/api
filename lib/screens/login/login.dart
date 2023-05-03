import 'package:api/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

import '../../utils/app_urls.dart';
import '../../utils/colors.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: SingleChildScrollView(
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              children: [
                Text(
                  'Login to your account',
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
                  controller: controller.emailController,
                  hintText: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => controller.email = value!,
                  validator: (value) => controller.validateEmail(value!),
                  prefixIcon: true,
                  icon: Icons.email,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextInput(
                  controller: controller.passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (value) => controller.password = value!,
                  validator: (value) => controller.validatePassword(value!),
                  prefixIcon: true,
                  icon: Icons.lock,
                ),
                SizedBox(
                  height: 30.h,
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
                      'Sign In',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Forgot password',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: const Color.fromARGB(255, 23, 105, 172),
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(
                  height: 40.h,
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
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () => Get.offNamed(AppUrls.registerRoute),
                  child: Text(
                    "Don't an account ? Create here.",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 23, 105, 172),
                      fontSize: 14.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
