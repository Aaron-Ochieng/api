import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/time_ago.dart';
import '../home_controller.dart';

class PostCard extends GetView<HomeController> {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.posts.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var post = controller.posts[index];
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10.h),
            margin: EdgeInsets.only(bottom: 10.h),
            decoration: BoxDecoration(
                color: AppColors.postBackground,
                borderRadius: BorderRadius.circular(8.h)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      foregroundImage: post.author.profile_img_url != null
                          ? NetworkImage(
                              'http://10.42.0.1:5000${post.author.profile_img_url}',
                            )
                          : null,
                      child: Text(post.author.username[0]),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              post.author.username,
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            post.author.verified
                                ? SvgPicture.asset(
                                    height: 15.h,
                                    width: 15.w,
                                    'assets/users/authentic1.svg',
                                    colorFilter: ColorFilter.mode(
                                      AppColors.pinkColorAccent,
                                      BlendMode.srcIn,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        Text(
                          TimeAgo().getTimeAgo(post.updated_at),
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  children: [
                    Text(
                      post.body,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 13.sp,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                post.image_url != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.h),
                        child: CachedNetworkImage(
                          imageUrl: 'http://10.42.0.1:5000${post.image_url}',
                          height: 250.h,
                          width: double.maxFinite,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(
                            FluentIcons.error_circle_20_filled,
                            color: Colors.red,
                          ),
                        ),
                      )
                    : const Divider(),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 30.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => controller.likePost(index),
                                child: Icon(
                                  post.liked
                                      ? FluentIcons.heart_20_filled
                                      : FluentIcons.heart_20_regular,
                                  size: 20.r,
                                  color: Colors.pinkAccent.withOpacity(0.7),
                                ),
                              ),
                              Text(
                                post.likes.toString(),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Lato',
                                  color: Colors.pinkAccent.withOpacity(0.5),
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Row(
                            children: [
                              Icon(
                                FluentIcons.chat_empty_20_regular,
                                size: 20.r,
                                color: Colors.black54,
                              ),
                              Text(
                                post.comment_count.toString(),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Lato',
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            height: 25.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: Colors.blue.withOpacity(0.3),
                              ),
                            ),
                          ),
                          Icon(
                            FluentIcons.send_20_filled,
                            size: 20.r,
                            color: Colors.blueAccent.withOpacity(0.5),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
