import 'dart:convert';
import 'dart:io';
import 'package:api/utils/app_urls.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/posts_model.dart';
import '../../utils/colors.dart';
import '../../widgets/text_input.dart';

class HomeController extends GetxController {
  late TextEditingController postBodyController;
  final GlobalKey<FormState> newPostFormKey = GlobalKey<FormState>();

  var postBody = '';
  final Rx<File?> selectedFile = Rx<File?>(null);
  static String dateTime = DateTime.now().toIso8601String();

  @override
  onInit() {
    fetchNewPosts();
    postBodyController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    postBodyController.dispose();
    super.onClose();
  }

  RxList<PostModel> posts = RxList<PostModel>([]);

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedFile.value = File(pickedFile.path);
    }
  }

  newPostSheet() {
    return Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 223, 231),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15.h),
          child: SingleChildScrollView(
            child: Form(
              key: newPostFormKey,
              child: Column(
                children: [
                  Text(
                    'New Post',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.pinkColorAccent,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextInput(
                    controller: postBodyController,
                    hintText: 'Post',
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) => postBody = value!,
                    validator: (value) => validatePostbody(value!),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Obx(() {
                    if (selectedFile.value != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: Image.file(
                          selectedFile.value!,
                          height: 250.h,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _pickImage(ImageSource.gallery),
                        child: Icon(
                          FluentIcons.image_20_regular,
                          color: Colors.blue,
                          size: 30.h,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _pickImage(ImageSource.camera),
                        child: Icon(
                          FluentIcons.camera_20_regular,
                          color: Colors.blue,
                          size: 30.h,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () => submitForm(),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors.pinkColorAccent),
                      ),
                      child: Text(
                        'Create Post',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validatePostbody(String value) {
    if (value.isEmpty) {
      return "Post content required";
    }
    return null;
  }

  Future<http.Response> newPost(String body, File? file, String token) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppUrls.baseURL}/posts/'),
    )
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['updated_at'] = dateTime
      ..fields['body'] = body;
    // ignore: avoid_print
    print(DateTime.now.toString());
    if (file != null) {
      request.files.add(
        await http.MultipartFile.fromPath('file', file.path),
      );
    }

    return await http.Response.fromStream(await request.send());
  }

  void submitForm() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    final isValid = newPostFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    newPostFormKey.currentState!.save();
    final response = await newPost(postBody, selectedFile.value, token!);
    if (response.statusCode == 201) {
      await Get.defaultDialog(
        title: "Success",
        content: const Text('Post created sucessfully'),
        onConfirm: () => Get.back(),
      );
      postBodyController.clear();
      selectedFile.value = null;
      Get.back();
    } else {
      return await Get.defaultDialog(
        title: "Error",
        content: const Text('Something went wrong'),
        onCancel: () => Get.back(),
        onConfirm: () => Get.back(),
      );
    }
  }

  void fetchNewPosts() {
    Future.delayed(const Duration(milliseconds: 500), () {
      fetchPosts();
    });
  }

  Future<void> fetchPosts() async {
    String? token = await AppUrls().getAcessToken();
    final response = await http.get(
      Uri.parse('${AppUrls.baseURL}/posts/'),
      headers: {'Authorization': 'Bearer $token'},
    );
    // ignore: avoid_print
    print(response.headers.toString());
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (posts.isNotEmpty) {
        posts.clear();
      }
      posts.assignAll(data.map((json) => PostModel.fromJson(json)).toList());
    } else {
      Get.dialog(
        AlertDialog(
          title: const Text("Error"),
          content: const Text(
            'Failed to load posts',
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            ElevatedButton(onPressed: () => Get.back(), child: const Text('Ok'))
          ],
        ),
      );
    }
  }

  ///Like a post
  ///
  Future<http.Response> likePost(int id) async {
    String? token = await AppUrls().getAcessToken();
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppUrls.baseURL}/posts/$id/like'),
    )..headers['Authorization'] = 'Bearer $token';

    return await http.Response.fromStream(await request.send());
  }

  void submitLike(int id) async {
    await likePost(id);
  }
}
