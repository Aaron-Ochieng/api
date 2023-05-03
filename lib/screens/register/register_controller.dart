import 'package:api/utils/app_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  late TextEditingController emailController,
      passwordController,
      usernameController,
      confirmPasswordController;
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  var username = "";
  var confirmPassword = "";

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController = TextEditingController();
    confirmPasswordController.dispose();
    super.onClose();
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email required";
    }
    if (!GetUtils.isEmail(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password required";
    }
    return null;
  }

  String? validateUserName(String value) {
    if (value.isEmpty) {
      return "Username required";
    }

    if (value.length < 3) {
      return 'Username must be 3 characters and above';
    }
    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return "Confirm password required";
    }
    if (value != passwordController.text) {
      return 'Passwords do not match ';
    }
    return null;
  }

  Future<http.Response> sendFormInput(
      String username, String email, String password) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${AppUrls.baseURL}/auth/register'))
      ..fields['username'] = username
      ..fields['email'] = email
      ..fields['password'] = password;
    return await http.Response.fromStream(await request.send());
  }

  void submitForm() async {
    final isValid = registerFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    registerFormKey.currentState!.save();
    final response = await sendFormInput(username, email, password);

    if (response.statusCode == 201) {
      await Get.defaultDialog(
        title: "Success",
        content: const Text('Registered new account sucessfully'),
        onConfirm: () => Get.back(),
      );
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      usernameController.clear();
    }
  }
}
