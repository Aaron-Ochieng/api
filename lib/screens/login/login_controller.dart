import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_urls.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passwordController;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  //
  var email = "";
  var password = "";

  //
  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validateEmail(String value) {
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

  Future<http.Response> sendLoginRequest(String email, String password) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppUrls.baseURL}/auth/login'),
    )
      ..fields['email'] = email
      ..fields['password'] = password;
    return await http.Response.fromStream(await request.send());
  }

  void submitForm() async {
    final isValid = loginFormKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    loginFormKey.currentState!.save();
    final response = await sendLoginRequest(email, password);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['access_token'];
      AppUrls().setAcessToken(token);

      Get.offAndToNamed(AppUrls.initialRoute);
      emailController.clear();
      passwordController.clear();
    } else {
      // ignore: avoid_print
      print('bad request');
    }
  }
}
