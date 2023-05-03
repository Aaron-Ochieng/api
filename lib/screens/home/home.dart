import 'package:api/screens/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import 'widgets/post_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60.h,
        elevation: 0,
        backgroundColor: AppColors.scaffoldBackground,
        title: Text(
          'Flutter Social',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Kufam',
            fontSize: 20.sp,
            color: AppColors.pinkColorAccent,
          ),
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () => controller.newPostSheet(),
                child: Icon(
                  Icons.add,
                  color: AppColors.pinkColorAccent,
                  size: 25.r,
                ),
              ),
              SizedBox(
                width: 25.w,
              )
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (controller.posts.isEmpty) {
          return RefreshIndicator(
            onRefresh: controller.fetchPosts,
            child: const Center(
              child: Text('No posts yet'),
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: controller.fetchPosts,
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: const PostCard(),
            ),
          );
        }
      }),
    );
  }
}
