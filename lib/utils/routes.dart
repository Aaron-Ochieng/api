import 'package:get/get.dart';

import '../screens/home/home.dart';
import '../screens/home/home_binding.dart';
import '../screens/login/login.dart';
import '../screens/login/login_binding.dart';
import '../screens/main/main_screen.dart';
import '../screens/message/message.dart';
import '../screens/message/message_binding.dart';
import '../screens/profile/profile.dart';
import '../screens/profile/profile_binding.dart';
import '../screens/register/register.dart';
import '../screens/register/register_binding.dart';
import 'app_urls.dart';

class AppRoutes {
  static List<GetPage> pages = [
    GetPage(
      name: AppUrls.initialRoute,
      page: () => const MainView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppUrls.profileRoute,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppUrls.messageRoute,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: AppUrls.homeRoute,
      page: () => const HomeView(),
    ),
    GetPage(
      name: AppUrls.loginRoute,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppUrls.registerRoute,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
  ];
}
