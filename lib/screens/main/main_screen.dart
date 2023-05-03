import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';
import '../home/home.dart';
import '../message/message.dart';
import '../profile/profile.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

// var controller = Get.put(HomeController()).fetchPosts();

int currentScreen = 0;
List<Widget> _screens = [
  const HomeView(),
  const MessageView(),
  const ProfileView(),
];

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentScreen,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: AppColors.scaffoldBackground,
          selectedFontSize: 0,
          selectedItemColor: Colors.pinkAccent,
          unselectedLabelStyle: TextStyle(fontSize: 0.sp),
          currentIndex: currentScreen,
          onTap: (value) {
            setState(() {
              currentScreen = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              activeIcon: Icon(
                FluentIcons.home_20_filled,
              ),
              icon: Icon(
                FluentIcons.home_20_regular,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Message',
              activeIcon: Icon(
                FluentIcons.chat_20_filled,
              ),
              icon: Icon(
                FluentIcons.chat_20_regular,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              activeIcon: Icon(
                FluentIcons.person_20_filled,
              ),
              icon: Icon(
                FluentIcons.person_20_regular,
              ),
            )
          ]),
    );
  }
}
