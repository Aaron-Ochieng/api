import 'package:shared_preferences/shared_preferences.dart';

class AppUrls {
  static String baseURL = 'http://10.42.0.1:5000';

  static String initialRoute = '/';
  static String homeRoute = '/home';
  static String profileRoute = '/profile';
  static String messageRoute = '/messages';
  static String loginRoute = '/login';
  static String registerRoute = '/register';

  static String? accessToken = '';

  Future<String?> getAcessToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }

  setAcessToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('token', token);
  }
}
